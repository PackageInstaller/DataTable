using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using ACT.Error;
using Unity.VisualScripting;
using UnityEngine;
using YooAsset;

namespace ACT;

internal class InitDll : GameLoadingFlowBase
{
	private enum DllStep
	{
		LoadAsset,
		LoadMetadata,
		LoadAssembly,
		LoadOver
	}

	private List<AssetHandle> _handles;

	private Dictionary<DllStep, Action> _stepActions;

	private DllStep _currentStep;

	private Assembly _hotUpdateAss;

	private Dictionary<string, byte[]> s_assetDatas = new Dictionary<string, byte[]>();

	internal override EGameLoadingStage Stage => EGameLoadingStage.Dll;

	private List<string> AOTMetaAssemblyFiles { get; } = AOTGenericReferences.PatchedAOTAssemblyList.ToList();

	internal override void Init(GameLoadingData data)
	{
		_handles = new List<AssetHandle>();
		_stepActions = new Dictionary<DllStep, Action>
		{
			{
				DllStep.LoadAsset,
				LoadAsset
			},
			{
				DllStep.LoadMetadata,
				LoadMetadata
			},
			{
				DllStep.LoadAssembly,
				LoadAssembly
			},
			{
				DllStep.LoadOver,
				LoadOver
			}
		};
		_currentStep = DllStep.LoadAsset;
		_loadState = EGameLoadingState.Loading;
	}

	internal override void Update()
	{
		if (_stepActions.TryGetValue(_currentStep, out var value) && _loadState == EGameLoadingState.Loading)
		{
			value?.Invoke();
		}
		else if (_loadState == EGameLoadingState.Loading)
		{
			Error("Unknown step");
			LuminErrorAOT.ReportGameLoadingError("C03-0705", "03", 0, $"步骤: {_currentStep}");
		}
	}

	public byte[] ReadBytesFromStreamingAssets(string dllName)
	{
		return s_assetDatas[dllName];
	}

	private void LoadAsset()
	{
		try
		{
			if (TickToNextStepByList(_handles, out var isSuccess))
			{
				if (isSuccess)
				{
					TurnToNextStep(DllStep.LoadMetadata);
				}
				return;
			}
			foreach (string asset in new List<string>(HotUpdateAssemblyReferences.HotUpdateAssemblyFiles).Concat(AOTMetaAssemblyFiles))
			{
				ResourcePackage package = YooAssets.GetPackage("Dll");
				AssetInfo assetInfo = package.GetAssetInfo(asset);
				if (assetInfo == null || assetInfo.IsInvalid)
				{
					continue;
				}
				AssetHandle assetHandle = package.LoadAssetAsync<TextAsset>(asset);
				TextAsset fileData;
				assetHandle.Completed += (AssetHandle x) =>
				{
					fileData = x.AssetObject as TextAsset;
					s_assetDatas[asset] = fileData.bytes;
					if (LuminApplication.LogEnabled)
					{
						Debug.Log($"dll:{asset} size:{fileData.bytes.Length}");
					}
				};
				_handles.Add(assetHandle);
			}
		}
		catch (Exception exception)
		{
			Exception(exception);
		}
	}

	private void LoadMetadata()
	{
		try
		{
			TurnToNextStep(DllStep.LoadAssembly);
		}
		catch (Exception exception)
		{
			Exception(exception);
		}
	}

	private void InitRPC(Assembly asm, string typeName)
	{
		MethodInfo methodInfo = asm.GetType(typeName)?.GetMethod("__initializeRpcs", BindingFlags.IgnoreCase | BindingFlags.Static | BindingFlags.NonPublic);
		if (methodInfo == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("无法找到[" + typeName + "]RPC初始化静态方法: __initializeRpcs");
			}
		}
		else
		{
			methodInfo?.Invoke(null, null);
		}
	}

	private void LoadAssembly()
	{
		try
		{
			List<Assembly> list = new List<Assembly>();
			foreach (string hotUpdateAssemblyFile in HotUpdateAssemblyReferences.HotUpdateAssemblyFiles)
			{
				Assembly assembly = Assembly.Load(ReadBytesFromStreamingAssets(hotUpdateAssemblyFile));
				list.Add(assembly);
				if (hotUpdateAssemblyFile.Equals("Assembly-ACT.dll"))
				{
					_hotUpdateAss = assembly;
				}
			}
			RuntimeCodebase.AddHotUpdateAssembly(list.ToArray());
			TurnToNextStep(DllStep.LoadOver);
		}
		catch (Exception exception)
		{
			Exception(exception);
		}
	}

	private void LoadOver()
	{
		if (_hotUpdateAss == null)
		{
			Error("热更程序集为空");
			LuminErrorAOT.ReportGameLoadingError("C03-0704", "03", 0);
			return;
		}
		foreach (AssetHandle handle in _handles)
		{
			handle.Release();
		}
		YooAssets.GetPackage("Dll").UnloadUnusedAssetsAsync();
		_hotUpdateAss.GetType("Hello").GetMethod("Run").Invoke(null, null);
		_loadState = EGameLoadingState.Succeed;
	}

	private bool TickToNextStepByList(List<AssetHandle> operations, out bool isSuccess)
	{
		isSuccess = true;
		if (operations == null || operations.Count == 0)
		{
			return false;
		}
		foreach (AssetHandle operation in operations)
		{
			if (operation.IsDone)
			{
				if (operation.Status != EOperationStatus.Succeed)
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogError($"Operation['{operation}'] : Error");
					}
					LuminErrorAOT.ReportGameLoadingError(_currentStep switch
					{
						DllStep.LoadAsset => "C03-0701", 
						DllStep.LoadMetadata => "C03-0702", 
						DllStep.LoadAssembly => "C03-0703", 
						_ => "C03-0705", 
					}, "03", 0, $"Option: {operation}");
					_loadState = EGameLoadingState.Failed;
				}
			}
			else
			{
				isSuccess = false;
			}
		}
		return true;
	}

	private void TurnToNextStep(DllStep nextStep)
	{
		_currentStep = nextStep;
	}
}
