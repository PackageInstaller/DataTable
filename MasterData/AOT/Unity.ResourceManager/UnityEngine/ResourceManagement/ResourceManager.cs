using System;
using System.Collections.Generic;
using UnityEngine.Networking;
using UnityEngine.ResourceManagement.AsyncOperations;
using UnityEngine.ResourceManagement.Exceptions;
using UnityEngine.ResourceManagement.Profiling;
using UnityEngine.ResourceManagement.ResourceLocations;
using UnityEngine.ResourceManagement.ResourceProviders;
using UnityEngine.ResourceManagement.Util;
using UnityEngine.SceneManagement;

namespace UnityEngine.ResourceManagement;

public class ResourceManager : IDisposable
{
	public enum DiagnosticEventType
	{
		AsyncOperationFail,
		AsyncOperationCreate,
		AsyncOperationPercentComplete,
		AsyncOperationComplete,
		AsyncOperationReferenceCount,
		AsyncOperationDestroy
	}

	public struct DiagnosticEventContext
	{
		public AsyncOperationHandle OperationHandle { get; }

		public DiagnosticEventType Type { get; }

		public int EventValue { get; }

		public IResourceLocation Location { get; }

		public object Context { get; }

		public string Error { get; }

		public DiagnosticEventContext(AsyncOperationHandle op, DiagnosticEventType type, int eventValue = 0, string error = null, object context = null)
		{
			OperationHandle = op;
			Type = type;
			EventValue = eventValue;
			Location = ((op.m_InternalOp != null && op.m_InternalOp is IGenericProviderOperation genericProviderOperation) ? genericProviderOperation.Location : null);
			Error = error;
			Context = context;
		}
	}

	private struct DeferredCallbackRegisterRequest
	{
		internal IAsyncOperation operation;

		internal bool incrementRefCount;
	}

	private class CompletedOperation<TObject> : AsyncOperationBase<TObject>
	{
		private bool m_Success;

		private Exception m_Exception;

		private bool m_ReleaseDependenciesOnFailure;

		protected override string DebugName => "CompletedOperation";

		public void Init(TObject result, bool success, string errorMsg, bool releaseDependenciesOnFailure = true)
		{
			Init(result, success, (!string.IsNullOrEmpty(errorMsg)) ? new Exception(errorMsg) : null, releaseDependenciesOnFailure);
		}

		public void Init(TObject result, bool success, Exception exception, bool releaseDependenciesOnFailure = true)
		{
			Result = result;
			m_Success = success;
			m_Exception = exception;
			m_ReleaseDependenciesOnFailure = releaseDependenciesOnFailure;
		}

		protected override bool InvokeWaitForCompletion()
		{
			m_RM?.Update(Time.unscaledDeltaTime);
			if (!HasExecuted)
			{
				InvokeExecute();
			}
			return true;
		}

		protected override void Execute()
		{
			Complete(Result, m_Success, m_Exception, m_ReleaseDependenciesOnFailure);
		}
	}

	internal class InstanceOperation : AsyncOperationBase<GameObject>
	{
		private AsyncOperationHandle<GameObject> m_dependency;

		private InstantiationParameters m_instantiationParams;

		private IInstanceProvider m_instanceProvider;

		private GameObject m_instance;

		private Scene m_scene;

		protected override string DebugName
		{
			get
			{
				if (m_instanceProvider == null)
				{
					return "Instance<Invalid>";
				}
				return string.Format("Instance<{0}>({1}", m_instanceProvider.GetType().Name, m_dependency.IsValid() ? m_dependency.DebugName : "Invalid");
			}
		}

		protected override float Progress => m_dependency.PercentComplete;

		public void Init(ResourceManager rm, IInstanceProvider instanceProvider, InstantiationParameters instantiationParams, AsyncOperationHandle<GameObject> dependency)
		{
			m_RM = rm;
			m_dependency = dependency;
			m_instanceProvider = instanceProvider;
			m_instantiationParams = instantiationParams;
			m_scene = default;
		}

		internal override DownloadStatus GetDownloadStatus(HashSet<object> visited)
		{
			if (!m_dependency.IsValid())
			{
				return new DownloadStatus
				{
					IsDone = IsDone
				};
			}
			return m_dependency.InternalGetDownloadStatus(visited);
		}

		public override void GetDependencies(List<AsyncOperationHandle> deps)
		{
			deps.Add(m_dependency);
		}

		public Scene InstanceScene()
		{
			return m_scene;
		}

		protected override void Destroy()
		{
			m_instanceProvider.ReleaseInstance(m_RM, m_instance);
		}

		protected override bool InvokeWaitForCompletion()
		{
			if (m_dependency.IsValid() && !m_dependency.IsDone)
			{
				m_dependency.WaitForCompletion();
			}
			m_RM?.Update(Time.unscaledDeltaTime);
			if (m_instance == null && !HasExecuted)
			{
				InvokeExecute();
			}
			return IsDone;
		}

		protected override void Execute()
		{
			Exception operationException = m_dependency.OperationException;
			if (m_dependency.Status == AsyncOperationStatus.Succeeded)
			{
				m_instance = m_instanceProvider.ProvideInstance(m_RM, m_dependency, m_instantiationParams);
				if (m_instance != null)
				{
					m_scene = m_instance.scene;
				}
				Complete(m_instance, true, (string)null);
			}
			else
			{
				Complete(m_instance, success: false, $"Dependency operation failed with {operationException}.");
			}
		}
	}

	internal bool postProfilerEvents;

	internal bool CallbackHooksEnabled = true;

	private ListWithEvents<IResourceProvider> m_ResourceProviders = new ListWithEvents<IResourceProvider>();

	private IAllocationStrategy m_allocator;

	internal ListWithEvents<IUpdateReceiver> m_UpdateReceivers = new ListWithEvents<IUpdateReceiver>();

	private List<IUpdateReceiver> m_UpdateReceiversToRemove;

	private bool m_UpdatingReceivers;

	private bool m_InsideUpdateMethod;

	internal Dictionary<int, IResourceProvider> m_providerMap = new Dictionary<int, IResourceProvider>();

	private Dictionary<IOperationCacheKey, IAsyncOperation> m_AssetOperationCache = new Dictionary<IOperationCacheKey, IAsyncOperation>();

	private HashSet<InstanceOperation> m_TrackedInstanceOperations = new HashSet<InstanceOperation>();

	internal DelegateList<float> m_UpdateCallbacks = DelegateList<float>.CreateWithGlobalCache();

	private List<IAsyncOperation> m_DeferredCompleteCallbacks = new List<IAsyncOperation>();

	private bool m_InsideExecuteDeferredCallbacksMethod;

	private List<DeferredCallbackRegisterRequest> m_DeferredCallbacksToRegister;

	private Action<AsyncOperationHandle, DiagnosticEventType, int, object> m_obsoleteDiagnosticsHandler;

	private Action<DiagnosticEventContext> m_diagnosticsHandler;

	private Action<IAsyncOperation> m_ReleaseOpNonCached;

	private Action<IAsyncOperation> m_ReleaseOpCached;

	private Action<IAsyncOperation> m_ReleaseInstanceOp;

	private static int s_GroupOperationTypeHash = typeof(GroupOperation).GetHashCode();

	private static int s_InstanceOperationTypeHash = typeof(InstanceOperation).GetHashCode();

	private bool m_RegisteredForCallbacks;

	private Dictionary<Type, Type> m_ProviderOperationTypeCache = new Dictionary<Type, Type>();

	public static Action<AsyncOperationHandle, Exception> ExceptionHandler { get; set; }

	public Func<IResourceLocation, string> InternalIdTransformFunc { get; set; }

	public Action<UnityWebRequest> WebRequestOverride { get; set; }

	internal int OperationCacheCount => m_AssetOperationCache.Count;

	internal int InstanceOperationCount => m_TrackedInstanceOperations.Count;

	internal int DeferredCompleteCallbacksCount => m_DeferredCompleteCallbacks.Count;

	internal int DeferredCallbackCount => m_DeferredCallbacksToRegister?.Count ?? 0;

	public IAllocationStrategy Allocator
	{
		get
		{
			return m_allocator;
		}
		set
		{
			m_allocator = value;
		}
	}

	public IList<IResourceProvider> ResourceProviders => m_ResourceProviders;

	public CertificateHandler CertificateHandlerInstance { get; set; }

	public string TransformInternalId(IResourceLocation location)
	{
		if (InternalIdTransformFunc != null)
		{
			return InternalIdTransformFunc(location);
		}
		return location.InternalId;
	}

	public void AddUpdateReceiver(IUpdateReceiver receiver)
	{
		if (receiver != null)
		{
			m_UpdateReceivers.Add(receiver);
		}
	}

	public void RemoveUpdateReciever(IUpdateReceiver receiver)
	{
		if (receiver == null)
		{
			return;
		}
		if (m_UpdatingReceivers)
		{
			if (m_UpdateReceiversToRemove == null)
			{
				m_UpdateReceiversToRemove = new List<IUpdateReceiver>();
			}
			m_UpdateReceiversToRemove.Add(receiver);
		}
		else
		{
			m_UpdateReceivers.Remove(receiver);
		}
	}

	public ResourceManager(IAllocationStrategy alloc = null)
	{
		m_ReleaseOpNonCached = OnOperationDestroyNonCached;
		m_ReleaseOpCached = OnOperationDestroyCached;
		m_ReleaseInstanceOp = OnInstanceOperationDestroy;
		IAllocationStrategy allocator;
		if (alloc != null)
		{
			allocator = alloc;
		}
		else
		{
			IAllocationStrategy allocationStrategy = new LRUCacheAllocationStrategy(1000, 1000, 100, 10);
			allocator = allocationStrategy;
		}
		m_allocator = allocator;
		m_ResourceProviders.OnElementAdded += OnObjectAdded;
		m_ResourceProviders.OnElementRemoved += OnObjectRemoved;
		m_UpdateReceivers.OnElementAdded += (IUpdateReceiver x) =>
		{
			RegisterForCallbacks();
		};
		ProfilerRuntime.Initialise();
	}

	private void OnObjectAdded(object obj)
	{
		if (obj is IUpdateReceiver receiver)
		{
			AddUpdateReceiver(receiver);
		}
	}

	private void OnObjectRemoved(object obj)
	{
		if (obj is IUpdateReceiver receiver)
		{
			RemoveUpdateReciever(receiver);
		}
	}

	internal void RegisterForCallbacks()
	{
		if (CallbackHooksEnabled && !m_RegisteredForCallbacks)
		{
			m_RegisteredForCallbacks = true;
			ComponentSingleton<MonoBehaviourCallbackHooks>.Instance.OnUpdateDelegate += Update;
		}
	}

	[Obsolete("ClearDiagnosticsCallback is Obsolete, use ClearDiagnosticCallbacks instead.")]
	public void ClearDiagnosticsCallback()
	{
		m_diagnosticsHandler = null;
		m_obsoleteDiagnosticsHandler = null;
	}

	public void ClearDiagnosticCallbacks()
	{
		m_diagnosticsHandler = null;
		m_obsoleteDiagnosticsHandler = null;
	}

	public void UnregisterDiagnosticCallback(Action<DiagnosticEventContext> func)
	{
		if (m_diagnosticsHandler != null)
		{
			m_diagnosticsHandler = (Action<DiagnosticEventContext>)Delegate.Remove(m_diagnosticsHandler, func);
		}
		else
		{
			Debug.LogError("No Diagnostic callbacks registered, cannot remove callback.");
		}
	}

	[Obsolete]
	public void RegisterDiagnosticCallback(Action<AsyncOperationHandle, DiagnosticEventType, int, object> func)
	{
		m_obsoleteDiagnosticsHandler = func;
	}

	public void RegisterDiagnosticCallback(Action<DiagnosticEventContext> func)
	{
		m_diagnosticsHandler = (Action<DiagnosticEventContext>)Delegate.Combine(m_diagnosticsHandler, func);
	}

	internal void PostDiagnosticEvent(DiagnosticEventContext context)
	{
		m_diagnosticsHandler?.Invoke(context);
		if (m_obsoleteDiagnosticsHandler != null)
		{
			m_obsoleteDiagnosticsHandler(context.OperationHandle, context.Type, context.EventValue, string.IsNullOrEmpty(context.Error) ? context.Context : context.Error);
		}
	}

	public IResourceProvider GetResourceProvider(Type t, IResourceLocation location)
	{
		if (location != null)
		{
			IResourceProvider value = null;
			int key = location.ProviderId.GetHashCode() * 31 + ((!(t == null)) ? t.GetHashCode() : 0);
			if (!m_providerMap.TryGetValue(key, out value))
			{
				for (int i = 0; i < ResourceProviders.Count; i++)
				{
					IResourceProvider resourceProvider = ResourceProviders[i];
					if (resourceProvider.ProviderId.Equals(location.ProviderId, StringComparison.Ordinal) && (t == null || resourceProvider.CanProvide(t, location)))
					{
						m_providerMap.Add(key, value = resourceProvider);
						break;
					}
				}
			}
			return value;
		}
		return null;
	}

	private Type GetDefaultTypeForLocation(IResourceLocation loc)
	{
		IResourceProvider resourceProvider = GetResourceProvider(null, loc);
		if (resourceProvider == null)
		{
			return typeof(object);
		}
		Type defaultType = resourceProvider.GetDefaultType(loc);
		if (!(defaultType != null))
		{
			return typeof(object);
		}
		return defaultType;
	}

	private int CalculateLocationsHash(IList<IResourceLocation> locations, Type t = null)
	{
		if (locations == null || locations.Count == 0)
		{
			return 0;
		}
		int num = 17;
		foreach (IResourceLocation location in locations)
		{
			Type resultType = ((t != null) ? t : GetDefaultTypeForLocation(location));
			num = num * 31 + location.Hash(resultType);
		}
		return num;
	}

	private AsyncOperationHandle ProvideResource(IResourceLocation location, Type desiredType = null, bool releaseDependenciesOnFailure = true)
	{
		if (location == null)
		{
			throw new ArgumentNullException("location");
		}
		IResourceProvider resourceProvider = null;
		if (desiredType == null)
		{
			resourceProvider = GetResourceProvider(desiredType, location);
			if (resourceProvider == null)
			{
				UnknownResourceProviderException exception = new UnknownResourceProviderException(location);
				return CreateCompletedOperationInternal<object>(null, success: false, exception, releaseDependenciesOnFailure);
			}
			desiredType = resourceProvider.GetDefaultType(location);
		}
		if (resourceProvider == null)
		{
			resourceProvider = GetResourceProvider(desiredType, location);
		}
		IOperationCacheKey operationCacheKey = CreateCacheKeyForLocation(resourceProvider, location, desiredType);
		if (m_AssetOperationCache.TryGetValue(operationCacheKey, out var value))
		{
			value.IncrementReferenceCount();
			return new AsyncOperationHandle(value, location.ToString());
		}
		if (!m_ProviderOperationTypeCache.TryGetValue(desiredType, out var value2))
		{
			m_ProviderOperationTypeCache.Add(desiredType, value2 = typeof(ProviderOperation<>).MakeGenericType(desiredType));
		}
		value = CreateOperation<IAsyncOperation>(value2, value2.GetHashCode(), operationCacheKey, m_ReleaseOpCached);
		int dependencyHashCode = location.DependencyHashCode;
		AsyncOperationHandle<IList<AsyncOperationHandle>> asyncOperationHandle = (location.HasDependencies ? ProvideResourceGroupCached(location.Dependencies, dependencyHashCode, null, null, releaseDependenciesOnFailure) : default(AsyncOperationHandle<IList<AsyncOperationHandle>>));
		((IGenericProviderOperation)value).Init(this, resourceProvider, location, asyncOperationHandle, releaseDependenciesOnFailure);
		AsyncOperationHandle result = StartOperation(value, asyncOperationHandle);
		result.LocationName = location.ToString();
		if (asyncOperationHandle.IsValid())
		{
			asyncOperationHandle.Release();
		}
		return result;
	}

	internal IAsyncOperation GetOperationFromCache(IResourceLocation location, Type desiredType)
	{
		IResourceProvider resourceProvider = GetResourceProvider(desiredType, location);
		IOperationCacheKey key = CreateCacheKeyForLocation(resourceProvider, location, desiredType);
		if (m_AssetOperationCache.TryGetValue(key, out var value))
		{
			return value;
		}
		return null;
	}

	internal IOperationCacheKey CreateCacheKeyForLocation(IResourceProvider provider, IResourceLocation location, Type desiredType = null)
	{
		if (provider is AssetBundleProvider assetBundleProvider)
		{
			return assetBundleProvider.CreateCacheKeyForLocation(this, location, desiredType);
		}
		return new LocationCacheKey(location, desiredType);
	}

	public AsyncOperationHandle<TObject> ProvideResource<TObject>(IResourceLocation location)
	{
		return ProvideResource(location, typeof(TObject)).Convert<TObject>();
	}

	public AsyncOperationHandle<TObject> StartOperation<TObject>(AsyncOperationBase<TObject> operation, AsyncOperationHandle dependency)
	{
		operation.Start(this, dependency, m_UpdateCallbacks);
		return operation.Handle;
	}

	internal AsyncOperationHandle StartOperation(IAsyncOperation operation, AsyncOperationHandle dependency)
	{
		operation.Start(this, dependency, m_UpdateCallbacks);
		return operation.Handle;
	}

	private void OnInstanceOperationDestroy(IAsyncOperation o)
	{
		m_TrackedInstanceOperations.Remove(o as InstanceOperation);
		Allocator.Release(o.GetType().GetHashCode(), o);
	}

	private void OnOperationDestroyNonCached(IAsyncOperation o)
	{
		Allocator.Release(o.GetType().GetHashCode(), o);
	}

	private void OnOperationDestroyCached(IAsyncOperation o)
	{
		Allocator.Release(o.GetType().GetHashCode(), o);
		ICachable cachable = o as ICachable;
		if (cachable?.Key != null)
		{
			RemoveOperationFromCache(cachable.Key);
			cachable.Key = null;
		}
	}

	internal T CreateOperation<T>(Type actualType, int typeHash, IOperationCacheKey cacheKey, Action<IAsyncOperation> onDestroyAction) where T : IAsyncOperation
	{
		if (cacheKey == null)
		{
			T result = (T)Allocator.New(actualType, typeHash);
			result.OnDestroy = onDestroyAction;
			return result;
		}
		T val = (T)Allocator.New(actualType, typeHash);
		val.OnDestroy = onDestroyAction;
		if (val is ICachable cachable)
		{
			cachable.Key = cacheKey;
			AddOperationToCache(cacheKey, val);
		}
		return val;
	}

	internal void AddOperationToCache(IOperationCacheKey key, IAsyncOperation operation)
	{
		if (!IsOperationCached(key))
		{
			m_AssetOperationCache.Add(key, operation);
		}
	}

	internal bool RemoveOperationFromCache(IOperationCacheKey key)
	{
		if (!IsOperationCached(key))
		{
			return true;
		}
		return m_AssetOperationCache.Remove(key);
	}

	internal bool IsOperationCached(IOperationCacheKey key)
	{
		return m_AssetOperationCache.ContainsKey(key);
	}

	internal int CachedOperationCount()
	{
		return m_AssetOperationCache.Count;
	}

	internal void ClearOperationCache()
	{
		m_AssetOperationCache.Clear();
	}

	public AsyncOperationHandle<TObject> CreateCompletedOperation<TObject>(TObject result, string errorMsg)
	{
		bool flag = string.IsNullOrEmpty(errorMsg);
		return CreateCompletedOperationInternal(result, flag, (!flag) ? new Exception(errorMsg) : null);
	}

	public AsyncOperationHandle<TObject> CreateCompletedOperationWithException<TObject>(TObject result, Exception exception)
	{
		return CreateCompletedOperationInternal(result, exception == null, exception);
	}

	internal AsyncOperationHandle<TObject> CreateCompletedOperationInternal<TObject>(TObject result, bool success, Exception exception, bool releaseDependenciesOnFailure = true)
	{
		CompletedOperation<TObject> completedOperation = CreateOperation<CompletedOperation<TObject>>(typeof(CompletedOperation<TObject>), typeof(CompletedOperation<TObject>).GetHashCode(), null, m_ReleaseOpNonCached);
		completedOperation.Init(result, success, exception, releaseDependenciesOnFailure);
		return StartOperation(completedOperation, default);
	}

	public void Release(AsyncOperationHandle handle)
	{
		handle.Release();
	}

	public AsyncOperationHandle<TObject> Acquire<TObject>(AsyncOperationHandle<TObject> handle)
	{
		return handle.Acquire();
	}

	public void Acquire(AsyncOperationHandle handle)
	{
		handle.Acquire();
	}

	private GroupOperation AcquireGroupOpFromCache(IOperationCacheKey key)
	{
		if (m_AssetOperationCache.TryGetValue(key, out var value))
		{
			value.IncrementReferenceCount();
			return (GroupOperation)value;
		}
		return null;
	}

	public AsyncOperationHandle<IList<AsyncOperationHandle>> CreateGroupOperation<T>(IList<IResourceLocation> locations)
	{
		GroupOperation groupOperation = CreateOperation<GroupOperation>(typeof(GroupOperation), s_GroupOperationTypeHash, null, m_ReleaseOpNonCached);
		List<AsyncOperationHandle> list = new List<AsyncOperationHandle>(locations.Count);
		foreach (IResourceLocation location in locations)
		{
			list.Add(ProvideResource<T>(location));
		}
		groupOperation.Init(list);
		return StartOperation(groupOperation, default);
	}

	internal AsyncOperationHandle<IList<AsyncOperationHandle>> CreateGroupOperation<T>(IList<IResourceLocation> locations, bool allowFailedDependencies)
	{
		GroupOperation groupOperation = CreateOperation<GroupOperation>(typeof(GroupOperation), s_GroupOperationTypeHash, null, m_ReleaseOpNonCached);
		List<AsyncOperationHandle> list = new List<AsyncOperationHandle>(locations.Count);
		foreach (IResourceLocation location in locations)
		{
			list.Add(ProvideResource<T>(location));
		}
		GroupOperation.GroupOperationSettings groupOperationSettings = GroupOperation.GroupOperationSettings.None;
		if (allowFailedDependencies)
		{
			groupOperationSettings |= GroupOperation.GroupOperationSettings.AllowFailedDependencies;
		}
		groupOperation.Init(list, groupOperationSettings);
		return StartOperation(groupOperation, default);
	}

	public AsyncOperationHandle<IList<AsyncOperationHandle>> CreateGenericGroupOperation(List<AsyncOperationHandle> operations, bool releasedCachedOpOnComplete = false)
	{
		GroupOperation groupOperation = CreateOperation<GroupOperation>(typeof(GroupOperation), s_GroupOperationTypeHash, new AsyncOpHandlesCacheKey(operations), releasedCachedOpOnComplete ? m_ReleaseOpCached : m_ReleaseOpNonCached);
		groupOperation.Init(operations);
		return StartOperation(groupOperation, default);
	}

	internal AsyncOperationHandle<IList<AsyncOperationHandle>> ProvideResourceGroupCached(IList<IResourceLocation> locations, int groupHash, Type desiredType, Action<AsyncOperationHandle> callback, bool releaseDependenciesOnFailure = true)
	{
		DependenciesCacheKey dependenciesCacheKey = new DependenciesCacheKey(locations, groupHash);
		GroupOperation groupOperation = AcquireGroupOpFromCache(dependenciesCacheKey);
		AsyncOperationHandle<IList<AsyncOperationHandle>> result;
		if (groupOperation == null)
		{
			groupOperation = CreateOperation<GroupOperation>(typeof(GroupOperation), s_GroupOperationTypeHash, dependenciesCacheKey, m_ReleaseOpCached);
			List<AsyncOperationHandle> list = new List<AsyncOperationHandle>(locations.Count);
			foreach (IResourceLocation location in locations)
			{
				list.Add(ProvideResource(location, desiredType, releaseDependenciesOnFailure));
			}
			groupOperation.Init(list, releaseDependenciesOnFailure);
			result = StartOperation(groupOperation, default);
		}
		else
		{
			result = groupOperation.Handle;
		}
		if (callback != null)
		{
			IList<AsyncOperationHandle> dependentOps = groupOperation.GetDependentOps();
			for (int i = 0; i < dependentOps.Count; i++)
			{
				AsyncOperationHandle asyncOperationHandle = dependentOps[i];
				asyncOperationHandle.Completed += callback;
			}
		}
		return result;
	}

	public AsyncOperationHandle<IList<TObject>> ProvideResources<TObject>(IList<IResourceLocation> locations, Action<TObject> callback = null)
	{
		return ProvideResources(locations, releaseDependenciesOnFailure: true, callback);
	}

	public AsyncOperationHandle<IList<TObject>> ProvideResources<TObject>(IList<IResourceLocation> locations, bool releaseDependenciesOnFailure, Action<TObject> callback = null)
	{
		if (locations == null)
		{
			return CreateCompletedOperation<IList<TObject>>(null, "Null Location");
		}
		Action<AsyncOperationHandle> callback2 = null;
		if (callback != null)
		{
			callback2 = (AsyncOperationHandle x) =>
			{
				callback((TObject)x.Result);
			};
		}
		AsyncOperationHandle<IList<AsyncOperationHandle>> asyncOperationHandle = ProvideResourceGroupCached(locations, CalculateLocationsHash(locations, typeof(TObject)), typeof(TObject), callback2, releaseDependenciesOnFailure);
		AsyncOperationHandle<IList<TObject>> result = CreateChainOperation(asyncOperationHandle, (AsyncOperationHandle resultHandle) =>
		{
			AsyncOperationHandle<IList<AsyncOperationHandle>> asyncOperationHandle2 = resultHandle.Convert<IList<AsyncOperationHandle>>();
			List<TObject> list = new List<TObject>();
			Exception ex = null;
			if (asyncOperationHandle2.Status == AsyncOperationStatus.Succeeded)
			{
				foreach (AsyncOperationHandle item in asyncOperationHandle2.Result)
				{
					list.Add(item.Convert<TObject>().Result);
				}
			}
			else
			{
				bool flag = false;
				if (!releaseDependenciesOnFailure)
				{
					foreach (AsyncOperationHandle item2 in asyncOperationHandle2.Result)
					{
						if (item2.Status == AsyncOperationStatus.Succeeded)
						{
							list.Add(item2.Convert<TObject>().Result);
							flag = true;
						}
						else
						{
							list.Add(default);
						}
					}
				}
				if (!flag)
				{
					list = null;
					ex = new ResourceManagerException("ProvideResources failed", asyncOperationHandle2.OperationException);
				}
				else
				{
					ex = new ResourceManagerException("Partial success in ProvideResources.  Some items failed to load. See earlier logs for more info.", asyncOperationHandle2.OperationException);
				}
			}
			return CreateCompletedOperationInternal((IList<TObject>)list, ex == null, ex, releaseDependenciesOnFailure);
		}, releaseDependenciesOnFailure);
		asyncOperationHandle.Release();
		return result;
	}

	public AsyncOperationHandle<TObject> CreateChainOperation<TObject, TObjectDependency>(AsyncOperationHandle<TObjectDependency> dependentOp, Func<AsyncOperationHandle<TObjectDependency>, AsyncOperationHandle<TObject>> callback)
	{
		ChainOperation<TObject, TObjectDependency> chainOperation = CreateOperation<ChainOperation<TObject, TObjectDependency>>(typeof(ChainOperation<TObject, TObjectDependency>), typeof(ChainOperation<TObject, TObjectDependency>).GetHashCode(), null, null);
		chainOperation.Init(dependentOp, callback, releaseDependenciesOnFailure: true);
		return StartOperation(chainOperation, dependentOp);
	}

	public AsyncOperationHandle<TObject> CreateChainOperation<TObject>(AsyncOperationHandle dependentOp, Func<AsyncOperationHandle, AsyncOperationHandle<TObject>> callback)
	{
		ChainOperationTypelessDepedency<TObject> chainOperationTypelessDepedency = new ChainOperationTypelessDepedency<TObject>();
		chainOperationTypelessDepedency.Init(dependentOp, callback, releaseDependenciesOnFailure: true);
		return StartOperation(chainOperationTypelessDepedency, dependentOp);
	}

	public AsyncOperationHandle<TObject> CreateChainOperation<TObject, TObjectDependency>(AsyncOperationHandle<TObjectDependency> dependentOp, Func<AsyncOperationHandle<TObjectDependency>, AsyncOperationHandle<TObject>> callback, bool releaseDependenciesOnFailure = true)
	{
		ChainOperation<TObject, TObjectDependency> chainOperation = CreateOperation<ChainOperation<TObject, TObjectDependency>>(typeof(ChainOperation<TObject, TObjectDependency>), typeof(ChainOperation<TObject, TObjectDependency>).GetHashCode(), null, null);
		chainOperation.Init(dependentOp, callback, releaseDependenciesOnFailure);
		return StartOperation(chainOperation, dependentOp);
	}

	public AsyncOperationHandle<TObject> CreateChainOperation<TObject>(AsyncOperationHandle dependentOp, Func<AsyncOperationHandle, AsyncOperationHandle<TObject>> callback, bool releaseDependenciesOnFailure = true)
	{
		ChainOperationTypelessDepedency<TObject> chainOperationTypelessDepedency = new ChainOperationTypelessDepedency<TObject>();
		chainOperationTypelessDepedency.Init(dependentOp, callback, releaseDependenciesOnFailure);
		return StartOperation(chainOperationTypelessDepedency, dependentOp);
	}

	public AsyncOperationHandle<SceneInstance> ProvideScene(ISceneProvider sceneProvider, IResourceLocation location, LoadSceneMode loadSceneMode, bool activateOnLoad, int priority)
	{
		if (sceneProvider == null)
		{
			throw new NullReferenceException("sceneProvider is null");
		}
		return sceneProvider.ProvideScene(this, location, new LoadSceneParameters(loadSceneMode), activateOnLoad, priority);
	}

	public AsyncOperationHandle<SceneInstance> ProvideScene(ISceneProvider sceneProvider, IResourceLocation location, LoadSceneParameters loadSceneParameters, bool activateOnLoad, int priority)
	{
		if (sceneProvider == null)
		{
			throw new NullReferenceException("sceneProvider is null");
		}
		return sceneProvider.ProvideScene(this, location, loadSceneParameters, activateOnLoad, priority);
	}

	public AsyncOperationHandle<SceneInstance> ReleaseScene(ISceneProvider sceneProvider, AsyncOperationHandle<SceneInstance> sceneLoadHandle)
	{
		if (sceneProvider == null)
		{
			throw new NullReferenceException("sceneProvider is null");
		}
		return sceneProvider.ReleaseScene(this, sceneLoadHandle);
	}

	public AsyncOperationHandle<GameObject> ProvideInstance(IInstanceProvider provider, IResourceLocation location, InstantiationParameters instantiateParameters)
	{
		if (provider == null)
		{
			throw new NullReferenceException("provider is null.  Assign a valid IInstanceProvider object before using.");
		}
		if (location == null)
		{
			throw new ArgumentNullException("location");
		}
		AsyncOperationHandle<GameObject> asyncOperationHandle = ProvideResource<GameObject>(location);
		InstanceOperation instanceOperation = CreateOperation<InstanceOperation>(typeof(InstanceOperation), s_InstanceOperationTypeHash, null, m_ReleaseInstanceOp);
		instanceOperation.Init(this, provider, instantiateParameters, asyncOperationHandle);
		m_TrackedInstanceOperations.Add(instanceOperation);
		return StartOperation(instanceOperation, asyncOperationHandle);
	}

	public void CleanupSceneInstances(Scene scene)
	{
		List<InstanceOperation> list = null;
		foreach (InstanceOperation trackedInstanceOperation in m_TrackedInstanceOperations)
		{
			if (trackedInstanceOperation.Result == null && scene == trackedInstanceOperation.InstanceScene())
			{
				if (list == null)
				{
					list = new List<InstanceOperation>();
				}
				list.Add(trackedInstanceOperation);
			}
		}
		if (list == null)
		{
			return;
		}
		foreach (InstanceOperation item in list)
		{
			m_TrackedInstanceOperations.Remove(item);
			item.DecrementReferenceCount();
		}
	}

	private void ExecuteDeferredCallbacks()
	{
		m_InsideExecuteDeferredCallbacksMethod = true;
		for (int i = 0; i < m_DeferredCompleteCallbacks.Count; i++)
		{
			m_DeferredCompleteCallbacks[i].InvokeCompletionEvent();
			m_DeferredCompleteCallbacks[i].DecrementReferenceCount();
		}
		m_DeferredCompleteCallbacks.Clear();
		m_InsideExecuteDeferredCallbacksMethod = false;
	}

	internal void RegisterForDeferredCallback(IAsyncOperation op, bool incrementRefCount = true)
	{
		if (CallbackHooksEnabled && m_InsideExecuteDeferredCallbacksMethod)
		{
			if (m_DeferredCallbacksToRegister == null)
			{
				m_DeferredCallbacksToRegister = new List<DeferredCallbackRegisterRequest>();
			}
			m_DeferredCallbacksToRegister.Add(new DeferredCallbackRegisterRequest
			{
				operation = op,
				incrementRefCount = incrementRefCount
			});
		}
		else
		{
			if (incrementRefCount)
			{
				op.IncrementReferenceCount();
			}
			m_DeferredCompleteCallbacks.Add(op);
			RegisterForCallbacks();
		}
	}

	internal void Update(float unscaledDeltaTime)
	{
		if (m_InsideUpdateMethod)
		{
			throw new Exception("Reentering the Update method is not allowed.  This can happen when calling WaitForCompletion on an operation while inside of a callback.");
		}
		m_InsideUpdateMethod = true;
		m_UpdateCallbacks.Invoke(unscaledDeltaTime);
		m_UpdatingReceivers = true;
		for (int i = 0; i < m_UpdateReceivers.Count; i++)
		{
			m_UpdateReceivers[i].Update(unscaledDeltaTime);
		}
		m_UpdatingReceivers = false;
		if (m_UpdateReceiversToRemove != null)
		{
			foreach (IUpdateReceiver item in m_UpdateReceiversToRemove)
			{
				m_UpdateReceivers.Remove(item);
			}
			m_UpdateReceiversToRemove = null;
		}
		if (m_DeferredCallbacksToRegister != null)
		{
			foreach (DeferredCallbackRegisterRequest item2 in m_DeferredCallbacksToRegister)
			{
				RegisterForDeferredCallback(item2.operation, item2.incrementRefCount);
			}
			m_DeferredCallbacksToRegister = null;
		}
		ExecuteDeferredCallbacks();
		m_InsideUpdateMethod = false;
	}

	public void Dispose()
	{
		if (ComponentSingleton<MonoBehaviourCallbackHooks>.Exists && m_RegisteredForCallbacks)
		{
			ComponentSingleton<MonoBehaviourCallbackHooks>.Instance.OnUpdateDelegate -= Update;
			m_RegisteredForCallbacks = false;
		}
	}
}
