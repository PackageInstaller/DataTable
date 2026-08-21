using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;
using UnityEngine.Internal;
using UnityEngine.Rendering;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Graphics/Mesh/MeshScriptBindings.h")]
[RequiredByNativeCode]
public sealed class Mesh : Object
{
	[NativeHeader("Runtime/Graphics/Mesh/MeshScriptBindings.h")]
	[StaticAccessor(/*Could not decode attribute arguments.*/)]
	public struct MeshData
	{
		[NativeDisableUnsafePtrRestriction]
		internal IntPtr m_Ptr;

		public int vertexBufferCount => GetVertexBufferCount(m_Ptr);

		public int subMeshCount
		{
			set
			{
				SetSubMeshCount(m_Ptr, value);
			}
		}

		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod(IsThreadSafe = true)]
		private static extern int GetVertexBufferCount(IntPtr self);

		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod(IsThreadSafe = true)]
		private static extern IntPtr GetVertexDataPtr(IntPtr self, int stream);

		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod(IsThreadSafe = true)]
		private static extern ulong GetVertexDataSize(IntPtr self, int stream);

		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod(IsThreadSafe = true)]
		private static extern IntPtr GetIndexDataPtr(IntPtr self);

		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod(IsThreadSafe = true)]
		private static extern ulong GetIndexDataSize(IntPtr self);

		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod(IsThreadSafe = true, ThrowsException = true)]
		private static extern void SetVertexBufferParamsFromArray(IntPtr self, int vertexCount, [Unmarshalled] params VertexAttributeDescriptor[] attributes);

		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod(IsThreadSafe = true, ThrowsException = true)]
		private static extern void SetIndexBufferParamsImpl(IntPtr self, int indexCount, IndexFormat indexFormat);

		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod(IsThreadSafe = true)]
		private static extern void SetSubMeshCount(IntPtr self, int count);

		[NativeMethod(IsThreadSafe = true, ThrowsException = true)]
		private static void SetSubMeshImpl(IntPtr self, int index, SubMeshDescriptor desc, MeshUpdateFlags flags)
		{
			SetSubMeshImpl_Injected(self, index, ref desc, flags);
		}

		public unsafe NativeArray<T> GetVertexData<T>([DefaultValue("0")] int stream = 0) where T : struct
		{
			if (stream < 0 || stream >= vertexBufferCount)
			{
				throw new ArgumentOutOfRangeException(string.Format("{0} out of bounds, should be below {1} but was {2}", "stream", vertexBufferCount, stream));
			}
			ulong vertexDataSize = GetVertexDataSize(m_Ptr, stream);
			ulong num = (ulong)UnsafeUtility.SizeOf<T>();
			if (vertexDataSize % num != 0)
			{
				throw new ArgumentException(string.Format("Type passed to {0} can't capture the vertex buffer. Mesh vertex buffer size is {1} which is not a multiple of type size {2}", "GetVertexData", vertexDataSize, num));
			}
			ulong num2 = vertexDataSize / num;
			return NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<T>((void*)GetVertexDataPtr(m_Ptr, stream), (int)num2, Allocator.None);
		}

		public void SetVertexBufferParams(int vertexCount, params VertexAttributeDescriptor[] attributes)
		{
			SetVertexBufferParamsFromArray(m_Ptr, vertexCount, attributes);
		}

		public void SetIndexBufferParams(int indexCount, IndexFormat format)
		{
			SetIndexBufferParamsImpl(m_Ptr, indexCount, format);
		}

		public unsafe NativeArray<T> GetIndexData<T>() where T : struct
		{
			ulong indexDataSize = GetIndexDataSize(m_Ptr);
			ulong num = (ulong)UnsafeUtility.SizeOf<T>();
			if (indexDataSize % num != 0)
			{
				throw new ArgumentException(string.Format("Type passed to {0} can't capture the index buffer. Mesh index buffer size is {1} which is not a multiple of type size {2}", "GetIndexData", indexDataSize, num));
			}
			ulong num2 = indexDataSize / num;
			return NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<T>((void*)GetIndexDataPtr(m_Ptr), (int)num2, Allocator.None);
		}

		public void SetSubMesh(int index, SubMeshDescriptor desc, MeshUpdateFlags flags = MeshUpdateFlags.Default)
		{
			SetSubMeshImpl(m_Ptr, index, desc, flags);
		}

		[MethodImpl((MethodImplOptions)4096)]
		private static extern void SetSubMeshImpl_Injected(IntPtr self, int index, ref SubMeshDescriptor desc, MeshUpdateFlags flags);
	}

	[StaticAccessor(/*Could not decode attribute arguments.*/)]
	[NativeContainer]
	[NativeContainerSupportsMinMaxWriteRestriction]
	public struct MeshDataArray : IDisposable
	{
		[NativeDisableUnsafePtrRestriction]
		private unsafe IntPtr* m_Ptrs;

		internal int m_Length;

		public int Length => m_Length;

		public unsafe MeshData this[int index]
		{
			get
			{
				MeshData result = default(MeshData);
				result.m_Ptr = m_Ptrs[index];
				return result;
			}
		}

		[MethodImpl((MethodImplOptions)4096)]
		private unsafe static extern void AcquireReadOnlyMeshData([NotNull("ArgumentNullException")] Mesh mesh, IntPtr* datas);

		[MethodImpl((MethodImplOptions)4096)]
		private unsafe static extern void AcquireReadOnlyMeshDatas([NotNull("ArgumentNullException")] Mesh[] meshes, IntPtr* datas, int count);

		[MethodImpl((MethodImplOptions)4096)]
		private unsafe static extern void ReleaseMeshDatas(IntPtr* datas, int count);

		[MethodImpl((MethodImplOptions)4096)]
		private unsafe static extern void CreateNewMeshDatas(IntPtr* datas, int count);

		[MethodImpl((MethodImplOptions)4096)]
		[NativeThrows]
		private unsafe static extern void ApplyToMeshesImpl([NotNull("ArgumentNullException")] Mesh[] meshes, IntPtr* datas, int count, MeshUpdateFlags flags);

		[MethodImpl((MethodImplOptions)4096)]
		[NativeThrows]
		private static extern void ApplyToMeshImpl([NotNull("ArgumentNullException")] Mesh mesh, IntPtr data, MeshUpdateFlags flags);

		public unsafe void Dispose()
		{
			if (m_Length != 0)
			{
				ReleaseMeshDatas(m_Ptrs, m_Length);
				UnsafeUtility.Free(m_Ptrs, Allocator.Persistent);
			}
			m_Ptrs = null;
			m_Length = 0;
		}

		internal unsafe void ApplyToMeshAndDispose(Mesh mesh, MeshUpdateFlags flags)
		{
			if (!mesh.canAccess)
			{
				throw new InvalidOperationException("Not allowed to access vertex data on mesh '" + mesh.name + "' (isReadable is false; Read/Write must be enabled in import settings)");
			}
			ApplyToMeshImpl(mesh, *m_Ptrs, flags);
			Dispose();
		}

		internal unsafe void ApplyToMeshesAndDispose(Mesh[] meshes, MeshUpdateFlags flags)
		{
			for (int i = 0; i < m_Length; i++)
			{
				Mesh mesh = meshes[i];
				if (mesh == null)
				{
					throw new ArgumentNullException("meshes", $"Mesh at index {i} is null");
				}
				if (!mesh.canAccess)
				{
					throw new InvalidOperationException($"Not allowed to access vertex data on mesh '{mesh.name}' at array index {i} (isReadable is false; Read/Write must be enabled in import settings)");
				}
			}
			ApplyToMeshesImpl(meshes, m_Ptrs, m_Length, flags);
			Dispose();
		}

		internal unsafe MeshDataArray(Mesh mesh, bool checkReadWrite = true)
		{
			if (mesh == null)
			{
				throw new ArgumentNullException("mesh", "Mesh is null");
			}
			if (checkReadWrite && !mesh.canAccess)
			{
				throw new InvalidOperationException("Not allowed to access vertex data on mesh '" + mesh.name + "' (isReadable is false; Read/Write must be enabled in import settings)");
			}
			m_Length = 1;
			int num = UnsafeUtility.SizeOf<IntPtr>();
			m_Ptrs = (IntPtr*)UnsafeUtility.Malloc(num, UnsafeUtility.AlignOf<IntPtr>(), Allocator.Persistent);
			AcquireReadOnlyMeshData(mesh, m_Ptrs);
		}

		internal unsafe MeshDataArray(Mesh[] meshes, int meshesCount, bool checkReadWrite = true)
		{
			if (meshes.Length < meshesCount)
			{
				throw new InvalidOperationException($"Meshes array size ({meshes.Length}) is smaller than meshes count ({meshesCount})");
			}
			for (int i = 0; i < meshesCount; i++)
			{
				Mesh mesh = meshes[i];
				if (mesh == null)
				{
					throw new ArgumentNullException("meshes", $"Mesh at index {i} is null");
				}
				if (checkReadWrite && !mesh.canAccess)
				{
					throw new InvalidOperationException($"Not allowed to access vertex data on mesh '{mesh.name}' at array index {i} (isReadable is false; Read/Write must be enabled in import settings)");
				}
			}
			m_Length = meshesCount;
			int num = UnsafeUtility.SizeOf<IntPtr>() * meshesCount;
			m_Ptrs = (IntPtr*)UnsafeUtility.Malloc(num, UnsafeUtility.AlignOf<IntPtr>(), Allocator.Persistent);
			AcquireReadOnlyMeshDatas(meshes, m_Ptrs, meshesCount);
		}

		internal unsafe MeshDataArray(int meshesCount)
		{
			if (meshesCount < 0)
			{
				throw new InvalidOperationException($"Mesh count can not be negative (was {meshesCount})");
			}
			m_Length = meshesCount;
			int num = UnsafeUtility.SizeOf<IntPtr>() * meshesCount;
			m_Ptrs = (IntPtr*)UnsafeUtility.Malloc(num, UnsafeUtility.AlignOf<IntPtr>(), Allocator.Persistent);
			CreateNewMeshDatas(m_Ptrs, meshesCount);
		}
	}

	public extern IndexFormat indexFormat
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern int vertexBufferCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "MeshScripting::GetVertexBufferCount", HasExplicitThis = true)]
		get;
	}

	public extern GraphicsBuffer.Target vertexBufferTarget
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern GraphicsBuffer.Target indexBufferTarget
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern int blendShapeCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod(Name = "GetBlendShapeChannelCount")]
		get;
	}

	[NativeName("BindPosesFromScript")]
	public extern Matrix4x4[] bindposes
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public extern bool isReadable
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("GetIsReadable")]
		get;
	}

	internal extern bool canAccess
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("CanAccessFromScript")]
		get;
	}

	public extern int vertexCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("GetVertexCount")]
		get;
	}

	public extern int subMeshCount
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod(Name = "GetSubMeshCount")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "MeshScripting::SetSubMeshCount", HasExplicitThis = true)]
		set;
	}

	public Bounds bounds
	{
		get
		{
			get_bounds_Injected(out var ret);
			return ret;
		}
		set
		{
			set_bounds_Injected(ref value);
		}
	}

	public Vector3[] vertices
	{
		get
		{
			return GetAllocArrayFromChannel<Vector3>(VertexAttribute.Position);
		}
		set
		{
			SetArrayForChannel(VertexAttribute.Position, value);
		}
	}

	public Vector3[] normals
	{
		get
		{
			return GetAllocArrayFromChannel<Vector3>(VertexAttribute.Normal);
		}
		set
		{
			SetArrayForChannel(VertexAttribute.Normal, value);
		}
	}

	public Vector4[] tangents
	{
		get
		{
			return GetAllocArrayFromChannel<Vector4>(VertexAttribute.Tangent);
		}
		set
		{
			SetArrayForChannel(VertexAttribute.Tangent, value);
		}
	}

	public Vector2[] uv
	{
		get
		{
			return GetAllocArrayFromChannel<Vector2>(VertexAttribute.TexCoord0);
		}
		set
		{
			SetArrayForChannel(VertexAttribute.TexCoord0, value);
		}
	}

	public Vector2[] uv2
	{
		get
		{
			return GetAllocArrayFromChannel<Vector2>(VertexAttribute.TexCoord1);
		}
		set
		{
			SetArrayForChannel(VertexAttribute.TexCoord1, value);
		}
	}

	public Vector2[] uv3
	{
		get
		{
			return GetAllocArrayFromChannel<Vector2>(VertexAttribute.TexCoord2);
		}
		set
		{
			SetArrayForChannel(VertexAttribute.TexCoord2, value);
		}
	}

	public Vector2[] uv4
	{
		get
		{
			return GetAllocArrayFromChannel<Vector2>(VertexAttribute.TexCoord3);
		}
		set
		{
			SetArrayForChannel(VertexAttribute.TexCoord3, value);
		}
	}

	public Vector2[] uv5
	{
		get
		{
			return GetAllocArrayFromChannel<Vector2>(VertexAttribute.TexCoord4);
		}
		set
		{
			SetArrayForChannel(VertexAttribute.TexCoord4, value);
		}
	}

	public Vector2[] uv6
	{
		get
		{
			return GetAllocArrayFromChannel<Vector2>(VertexAttribute.TexCoord5);
		}
		set
		{
			SetArrayForChannel(VertexAttribute.TexCoord5, value);
		}
	}

	public Vector2[] uv7
	{
		get
		{
			return GetAllocArrayFromChannel<Vector2>(VertexAttribute.TexCoord6);
		}
		set
		{
			SetArrayForChannel(VertexAttribute.TexCoord6, value);
		}
	}

	public Vector2[] uv8
	{
		get
		{
			return GetAllocArrayFromChannel<Vector2>(VertexAttribute.TexCoord7);
		}
		set
		{
			SetArrayForChannel(VertexAttribute.TexCoord7, value);
		}
	}

	public Color[] colors
	{
		get
		{
			return GetAllocArrayFromChannel<Color>(VertexAttribute.Color);
		}
		set
		{
			SetArrayForChannel(VertexAttribute.Color, value);
		}
	}

	public Color32[] colors32
	{
		get
		{
			return GetAllocArrayFromChannel<Color32>(VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4);
		}
		set
		{
			SetArrayForChannel(VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4, value);
		}
	}

	public int vertexAttributeCount => GetVertexAttributeCountImpl();

	public int[] triangles
	{
		get
		{
			if (canAccess)
			{
				return GetTrianglesImpl(-1, applyBaseVertex: true);
			}
			PrintErrorCantAccessIndices();
			return new int[0];
		}
		set
		{
			if (canAccess)
			{
				SetTrianglesImpl(-1, IndexFormat.UInt32, value, NoAllocHelpers.SafeLength(value), 0, NoAllocHelpers.SafeLength(value), calculateBounds: true, 0);
			}
			else
			{
				PrintErrorCantAccessIndices();
			}
		}
	}

	public BoneWeight[] boneWeights
	{
		get
		{
			return GetBoneWeightsImpl();
		}
		set
		{
			SetBoneWeightsImpl(value);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("MeshScripting::CreateMesh")]
	private static extern void Internal_Create([Writable] Mesh mono);

	[RequiredByNativeCode]
	public Mesh()
	{
		Internal_Create(this);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("MeshScripting::MeshFromInstanceId")]
	internal static extern Mesh FromInstanceID(int id);

	[MethodImpl((MethodImplOptions)4096)]
	internal extern uint GetTotalIndexCount();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::SetIndexBufferParams", HasExplicitThis = true, ThrowsException = true)]
	public extern void SetIndexBufferParams(int indexCount, IndexFormat format);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::InternalSetIndexBufferData", HasExplicitThis = true, ThrowsException = true)]
	private extern void InternalSetIndexBufferData(IntPtr data, int dataStart, int meshBufferStart, int count, int elemSize, MeshUpdateFlags flags);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::InternalSetIndexBufferDataFromArray", HasExplicitThis = true, ThrowsException = true)]
	private extern void InternalSetIndexBufferDataFromArray(Array data, int dataStart, int meshBufferStart, int count, int elemSize, MeshUpdateFlags flags);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::SetVertexBufferParamsFromPtr", HasExplicitThis = true, ThrowsException = true)]
	private extern void SetVertexBufferParamsFromPtr(int vertexCount, IntPtr attributesPtr, int attributesCount);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::SetVertexBufferParamsFromArray", HasExplicitThis = true, ThrowsException = true)]
	private extern void SetVertexBufferParamsFromArray(int vertexCount, [Unmarshalled] params VertexAttributeDescriptor[] attributes);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::InternalSetVertexBufferData", HasExplicitThis = true)]
	private extern void InternalSetVertexBufferData(int stream, IntPtr data, int dataStart, int meshBufferStart, int count, int elemSize, MeshUpdateFlags flags);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::InternalSetVertexBufferDataFromArray", HasExplicitThis = true)]
	private extern void InternalSetVertexBufferDataFromArray(int stream, Array data, int dataStart, int meshBufferStart, int count, int elemSize, MeshUpdateFlags flags);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetVertexAttributesAlloc", HasExplicitThis = true)]
	private extern Array GetVertexAttributesAlloc();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetVertexAttributesArray", HasExplicitThis = true)]
	private extern int GetVertexAttributesArray([Unmarshalled][NotNull("ArgumentNullException")] VertexAttributeDescriptor[] attributes);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetVertexAttributesList", HasExplicitThis = true)]
	private extern int GetVertexAttributesList([NotNull("ArgumentNullException")] List<VertexAttributeDescriptor> attributes);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetVertexAttributesCount", HasExplicitThis = true)]
	private extern int GetVertexAttributeCountImpl();

	[FreeFunction(Name = "MeshScripting::GetVertexAttributeByIndex", HasExplicitThis = true, ThrowsException = true)]
	public VertexAttributeDescriptor GetVertexAttribute(int index)
	{
		GetVertexAttribute_Injected(index, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetIndexStart", HasExplicitThis = true)]
	private extern uint GetIndexStartImpl(int submesh);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetIndexCount", HasExplicitThis = true)]
	private extern uint GetIndexCountImpl(int submesh);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetTrianglesCount", HasExplicitThis = true)]
	private extern uint GetTrianglesCountImpl(int submesh);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetBaseVertex", HasExplicitThis = true)]
	private extern uint GetBaseVertexImpl(int submesh);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetTriangles", HasExplicitThis = true)]
	private extern int[] GetTrianglesImpl(int submesh, bool applyBaseVertex);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetIndices", HasExplicitThis = true)]
	private extern int[] GetIndicesImpl(int submesh, bool applyBaseVertex);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "SetMeshIndicesFromScript", HasExplicitThis = true, ThrowsException = true)]
	private extern void SetIndicesImpl(int submesh, MeshTopology topology, IndexFormat indicesFormat, Array indices, int arrayStart, int arraySize, bool calculateBounds, int baseVertex);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "SetMeshIndicesFromNativeArray", HasExplicitThis = true, ThrowsException = true)]
	private extern void SetIndicesNativeArrayImpl(int submesh, MeshTopology topology, IndexFormat indicesFormat, IntPtr indices, int arrayStart, int arraySize, bool calculateBounds, int baseVertex);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::ExtractTrianglesToArray", HasExplicitThis = true)]
	private extern void GetTrianglesNonAllocImpl([Out] int[] values, int submesh, bool applyBaseVertex);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::ExtractTrianglesToArray16", HasExplicitThis = true)]
	private extern void GetTrianglesNonAllocImpl16([Out] ushort[] values, int submesh, bool applyBaseVertex);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::ExtractIndicesToArray", HasExplicitThis = true)]
	private extern void GetIndicesNonAllocImpl([Out] int[] values, int submesh, bool applyBaseVertex);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::ExtractIndicesToArray16", HasExplicitThis = true)]
	private extern void GetIndicesNonAllocImpl16([Out] ushort[] values, int submesh, bool applyBaseVertex);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::PrintErrorCantAccessChannel", HasExplicitThis = true)]
	private extern void PrintErrorCantAccessChannel(VertexAttribute ch);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::HasChannel", HasExplicitThis = true)]
	public extern bool HasVertexAttribute(VertexAttribute attr);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetChannelDimension", HasExplicitThis = true)]
	public extern int GetVertexAttributeDimension(VertexAttribute attr);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetChannelFormat", HasExplicitThis = true)]
	public extern VertexAttributeFormat GetVertexAttributeFormat(VertexAttribute attr);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetChannelStream", HasExplicitThis = true)]
	public extern int GetVertexAttributeStream(VertexAttribute attr);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetChannelOffset", HasExplicitThis = true)]
	public extern int GetVertexAttributeOffset(VertexAttribute attr);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "SetMeshComponentFromArrayFromScript", HasExplicitThis = true)]
	private extern void SetArrayForChannelImpl(VertexAttribute channel, VertexAttributeFormat format, int dim, Array values, int arraySize, int valuesStart, int valuesCount, MeshUpdateFlags flags);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "SetMeshComponentFromNativeArrayFromScript", HasExplicitThis = true)]
	private extern void SetNativeArrayForChannelImpl(VertexAttribute channel, VertexAttributeFormat format, int dim, IntPtr values, int arraySize, int valuesStart, int valuesCount, MeshUpdateFlags flags);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "AllocExtractMeshComponentFromScript", HasExplicitThis = true)]
	private extern Array GetAllocArrayFromChannelImpl(VertexAttribute channel, VertexAttributeFormat format, int dim);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "ExtractMeshComponentFromScript", HasExplicitThis = true)]
	private extern void GetArrayFromChannelImpl(VertexAttribute channel, VertexAttributeFormat format, int dim, Array values);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetVertexBufferStride", HasExplicitThis = true)]
	public extern int GetVertexBufferStride(int stream);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeThrows]
	[FreeFunction(Name = "MeshScripting::GetNativeVertexBufferPtr", HasExplicitThis = true)]
	public extern IntPtr GetNativeVertexBufferPtr(int index);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetNativeIndexBufferPtr", HasExplicitThis = true)]
	public extern IntPtr GetNativeIndexBufferPtr();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetVertexBufferPtr", HasExplicitThis = true, ThrowsException = true)]
	private extern GraphicsBuffer GetVertexBufferImpl(int index);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetIndexBufferPtr", HasExplicitThis = true, ThrowsException = true)]
	private extern GraphicsBuffer GetIndexBufferImpl();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::ClearBlendShapes", HasExplicitThis = true)]
	public extern void ClearBlendShapes();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetBlendShapeName", HasExplicitThis = true, ThrowsException = true)]
	public extern string GetBlendShapeName(int shapeIndex);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetBlendShapeIndex", HasExplicitThis = true, ThrowsException = true)]
	public extern int GetBlendShapeIndex(string blendShapeName);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetBlendShapeFrameCount", HasExplicitThis = true, ThrowsException = true)]
	public extern int GetBlendShapeFrameCount(int shapeIndex);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetBlendShapeFrameWeight", HasExplicitThis = true, ThrowsException = true)]
	public extern float GetBlendShapeFrameWeight(int shapeIndex, int frameIndex);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GetBlendShapeFrameVerticesFromScript", HasExplicitThis = true, ThrowsException = true)]
	public extern void GetBlendShapeFrameVertices(int shapeIndex, int frameIndex, [Unmarshalled] Vector3[] deltaVertices, [Unmarshalled] Vector3[] deltaNormals, [Unmarshalled] Vector3[] deltaTangents);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "AddBlendShapeFrameFromScript", HasExplicitThis = true, ThrowsException = true)]
	public extern void AddBlendShapeFrame(string shapeName, float frameWeight, [Unmarshalled] Vector3[] deltaVertices, [Unmarshalled] Vector3[] deltaNormals, [Unmarshalled] Vector3[] deltaTangents);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("HasBoneWeights")]
	private extern bool HasBoneWeights();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetBoneWeights", HasExplicitThis = true)]
	private extern BoneWeight[] GetBoneWeightsImpl();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::SetBoneWeights", HasExplicitThis = true)]
	private extern void SetBoneWeightsImpl(BoneWeight[] weights);

	public unsafe void SetBoneWeights(NativeArray<byte> bonesPerVertex, NativeArray<BoneWeight1> weights)
	{
		InternalSetBoneWeights((IntPtr)bonesPerVertex.GetUnsafeReadOnlyPtr(), bonesPerVertex.Length, (IntPtr)weights.GetUnsafeReadOnlyPtr(), weights.Length);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::SetBoneWeights", HasExplicitThis = true)]
	private extern void InternalSetBoneWeights(IntPtr bonesPerVertex, int bonesPerVertexSize, IntPtr weights, int weightsSize);

	public unsafe NativeArray<BoneWeight1> GetAllBoneWeights()
	{
		return NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<BoneWeight1>((void*)GetAllBoneWeightsArray(), GetAllBoneWeightsArraySize(), Allocator.None);
	}

	public unsafe NativeArray<byte> GetBonesPerVertex()
	{
		int length = (HasBoneWeights() ? vertexCount : 0);
		return NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<byte>((void*)GetBonesPerVertexArray(), length, Allocator.None);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetAllBoneWeightsArraySize", HasExplicitThis = true)]
	private extern int GetAllBoneWeightsArraySize();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetAllBoneWeightsArray", HasExplicitThis = true)]
	private extern IntPtr GetAllBoneWeightsArray();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetBonesPerVertexArray", HasExplicitThis = true)]
	private extern IntPtr GetBonesPerVertexArray();

	[MethodImpl((MethodImplOptions)4096)]
	private extern int GetBindposeCount();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::ExtractBoneWeightsIntoArray", HasExplicitThis = true)]
	private extern void GetBoneWeightsNonAllocImpl([Out] BoneWeight[] values);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::ExtractBindPosesIntoArray", HasExplicitThis = true)]
	private extern void GetBindposesNonAllocImpl([Out] Matrix4x4[] values);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::IsCloudResource", HasExplicitThis = true)]
	internal extern bool IsCloudResource();

	[FreeFunction("MeshScripting::SetSubMesh", HasExplicitThis = true, ThrowsException = true)]
	public void SetSubMesh(int index, SubMeshDescriptor desc, MeshUpdateFlags flags = MeshUpdateFlags.Default)
	{
		SetSubMesh_Injected(index, ref desc, flags);
	}

	[FreeFunction("MeshScripting::GetSubMesh", HasExplicitThis = true, ThrowsException = true)]
	public SubMeshDescriptor GetSubMesh(int index)
	{
		GetSubMesh_Injected(index, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("MeshScripting::SetAllSubMeshesAtOnceFromArray", HasExplicitThis = true, ThrowsException = true)]
	private extern void SetAllSubMeshesAtOnceFromArray(SubMeshDescriptor[] desc, int start, int count, MeshUpdateFlags flags = MeshUpdateFlags.Default);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("MeshScripting::SetAllSubMeshesAtOnceFromNativeArray", HasExplicitThis = true, ThrowsException = true)]
	private extern void SetAllSubMeshesAtOnceFromNativeArray(IntPtr desc, int start, int count, MeshUpdateFlags flags = MeshUpdateFlags.Default);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("Clear")]
	private extern void ClearImpl(bool keepVertexLayout);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("RecalculateBounds")]
	private extern void RecalculateBoundsImpl(MeshUpdateFlags flags);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("RecalculateNormals")]
	private extern void RecalculateNormalsImpl(MeshUpdateFlags flags);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("RecalculateTangents")]
	private extern void RecalculateTangentsImpl(MeshUpdateFlags flags);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("MarkDynamic")]
	private extern void MarkDynamicImpl();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("MarkModified")]
	public extern void MarkModified();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("UploadMeshData")]
	private extern void UploadMeshDataImpl(bool markNoLongerReadable);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MeshScripting::GetPrimitiveType", HasExplicitThis = true)]
	private extern MeshTopology GetTopologyImpl(int submesh);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("RecalculateMeshMetric")]
	private extern void RecalculateUVDistributionMetricImpl(int uvSetIndex, float uvAreaThreshold);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("RecalculateMeshMetrics")]
	private extern void RecalculateUVDistributionMetricsImpl(float uvAreaThreshold);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("GetMeshMetric")]
	public extern float GetUVDistributionMetric(int uvSetIndex);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "MeshScripting::CombineMeshes", IsFreeFunction = true, ThrowsException = true, HasExplicitThis = true)]
	private extern void CombineMeshesImpl(CombineInstance[] combine, bool mergeSubMeshes, bool useMatrices, bool hasLightmapData);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("Optimize")]
	private extern void OptimizeImpl();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("OptimizeIndexBuffers")]
	private extern void OptimizeIndexBuffersImpl();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("OptimizeReorderVertexBuffer")]
	private extern void OptimizeReorderVertexBufferImpl();

	internal static VertexAttribute GetUVChannel(int uvIndex)
	{
		if (uvIndex < 0 || uvIndex > 7)
		{
			throw new ArgumentException("GetUVChannel called for bad uvIndex", "uvIndex");
		}
		return (VertexAttribute)(4 + uvIndex);
	}

	internal static int DefaultDimensionForChannel(VertexAttribute channel)
	{
		if (channel == VertexAttribute.Position || channel == VertexAttribute.Normal)
		{
			return 3;
		}
		if (channel >= VertexAttribute.TexCoord0 && channel <= VertexAttribute.TexCoord7)
		{
			return 2;
		}
		if (channel == VertexAttribute.Tangent || channel == VertexAttribute.Color)
		{
			return 4;
		}
		throw new ArgumentException("DefaultDimensionForChannel called for bad channel", "channel");
	}

	private T[] GetAllocArrayFromChannel<T>(VertexAttribute channel, VertexAttributeFormat format, int dim)
	{
		if (canAccess)
		{
			if (HasVertexAttribute(channel))
			{
				return (T[])GetAllocArrayFromChannelImpl(channel, format, dim);
			}
		}
		else
		{
			PrintErrorCantAccessChannel(channel);
		}
		return new T[0];
	}

	private T[] GetAllocArrayFromChannel<T>(VertexAttribute channel)
	{
		return GetAllocArrayFromChannel<T>(channel, VertexAttributeFormat.Float32, DefaultDimensionForChannel(channel));
	}

	private void SetSizedArrayForChannel(VertexAttribute channel, VertexAttributeFormat format, int dim, Array values, int valuesArrayLength, int valuesStart, int valuesCount, MeshUpdateFlags flags)
	{
		if (canAccess)
		{
			if (valuesStart < 0)
			{
				throw new ArgumentOutOfRangeException("valuesStart", valuesStart, "Mesh data array start index can't be negative.");
			}
			if (valuesCount < 0)
			{
				throw new ArgumentOutOfRangeException("valuesCount", valuesCount, "Mesh data array length can't be negative.");
			}
			if (valuesStart >= valuesArrayLength && valuesCount != 0)
			{
				throw new ArgumentOutOfRangeException("valuesStart", valuesStart, "Mesh data array start is outside of array size.");
			}
			if (valuesStart + valuesCount > valuesArrayLength)
			{
				throw new ArgumentOutOfRangeException("valuesCount", valuesStart + valuesCount, "Mesh data array start+count is outside of array size.");
			}
			if (values == null)
			{
				valuesStart = 0;
			}
			SetArrayForChannelImpl(channel, format, dim, values, valuesArrayLength, valuesStart, valuesCount, flags);
		}
		else
		{
			PrintErrorCantAccessChannel(channel);
		}
	}

	private void SetSizedNativeArrayForChannel(VertexAttribute channel, VertexAttributeFormat format, int dim, IntPtr values, int valuesArrayLength, int valuesStart, int valuesCount, MeshUpdateFlags flags)
	{
		if (canAccess)
		{
			if (valuesStart < 0)
			{
				throw new ArgumentOutOfRangeException("valuesStart", valuesStart, "Mesh data array start index can't be negative.");
			}
			if (valuesCount < 0)
			{
				throw new ArgumentOutOfRangeException("valuesCount", valuesCount, "Mesh data array length can't be negative.");
			}
			if (valuesStart >= valuesArrayLength && valuesCount != 0)
			{
				throw new ArgumentOutOfRangeException("valuesStart", valuesStart, "Mesh data array start is outside of array size.");
			}
			if (valuesStart + valuesCount > valuesArrayLength)
			{
				throw new ArgumentOutOfRangeException("valuesCount", valuesStart + valuesCount, "Mesh data array start+count is outside of array size.");
			}
			SetNativeArrayForChannelImpl(channel, format, dim, values, valuesArrayLength, valuesStart, valuesCount, flags);
		}
		else
		{
			PrintErrorCantAccessChannel(channel);
		}
	}

	private void SetArrayForChannel<T>(VertexAttribute channel, VertexAttributeFormat format, int dim, T[] values, MeshUpdateFlags flags = MeshUpdateFlags.Default)
	{
		int num = NoAllocHelpers.SafeLength(values);
		SetSizedArrayForChannel(channel, format, dim, values, num, 0, num, flags);
	}

	private void SetArrayForChannel<T>(VertexAttribute channel, T[] values, MeshUpdateFlags flags = MeshUpdateFlags.Default)
	{
		int num = NoAllocHelpers.SafeLength(values);
		SetSizedArrayForChannel(channel, VertexAttributeFormat.Float32, DefaultDimensionForChannel(channel), values, num, 0, num, flags);
	}

	private void SetListForChannel<T>(VertexAttribute channel, VertexAttributeFormat format, int dim, List<T> values, int start, int length, MeshUpdateFlags flags)
	{
		SetSizedArrayForChannel(channel, format, dim, NoAllocHelpers.ExtractArrayFromList(values), NoAllocHelpers.SafeLength(values), start, length, flags);
	}

	private void SetListForChannel<T>(VertexAttribute channel, List<T> values, int start, int length, MeshUpdateFlags flags)
	{
		SetSizedArrayForChannel(channel, VertexAttributeFormat.Float32, DefaultDimensionForChannel(channel), NoAllocHelpers.ExtractArrayFromList(values), NoAllocHelpers.SafeLength(values), start, length, flags);
	}

	private void GetListForChannel<T>(List<T> buffer, int capacity, VertexAttribute channel, int dim)
	{
		GetListForChannel(buffer, capacity, channel, dim, VertexAttributeFormat.Float32);
	}

	private void GetListForChannel<T>(List<T> buffer, int capacity, VertexAttribute channel, int dim, VertexAttributeFormat channelType)
	{
		buffer.Clear();
		if (!canAccess)
		{
			PrintErrorCantAccessChannel(channel);
		}
		else if (HasVertexAttribute(channel))
		{
			NoAllocHelpers.EnsureListElemCount(buffer, capacity);
			GetArrayFromChannelImpl(channel, channelType, dim, NoAllocHelpers.ExtractArrayFromList(buffer));
		}
	}

	public void GetVertices(List<Vector3> vertices)
	{
		if (vertices == null)
		{
			throw new ArgumentNullException("vertices", "The result vertices list cannot be null.");
		}
		GetListForChannel(vertices, vertexCount, VertexAttribute.Position, DefaultDimensionForChannel(VertexAttribute.Position));
	}

	public void SetVertices(List<Vector3> inVertices)
	{
		SetVertices(inVertices, 0, NoAllocHelpers.SafeLength(inVertices));
	}

	[ExcludeFromDocs]
	public void SetVertices(List<Vector3> inVertices, int start, int length)
	{
		SetVertices(inVertices, start, length, MeshUpdateFlags.Default);
	}

	public void SetVertices(List<Vector3> inVertices, int start, int length, [DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags)
	{
		SetListForChannel(VertexAttribute.Position, inVertices, start, length, flags);
	}

	public void SetVertices(Vector3[] inVertices)
	{
		SetVertices(inVertices, 0, NoAllocHelpers.SafeLength(inVertices));
	}

	[ExcludeFromDocs]
	public void SetVertices(Vector3[] inVertices, int start, int length)
	{
		SetVertices(inVertices, start, length, MeshUpdateFlags.Default);
	}

	public void SetVertices(Vector3[] inVertices, int start, int length, [DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags)
	{
		SetSizedArrayForChannel(VertexAttribute.Position, VertexAttributeFormat.Float32, DefaultDimensionForChannel(VertexAttribute.Position), inVertices, NoAllocHelpers.SafeLength(inVertices), start, length, flags);
	}

	public void SetVertices<T>(NativeArray<T> inVertices) where T : struct
	{
		SetVertices(inVertices, 0, inVertices.Length);
	}

	[ExcludeFromDocs]
	public void SetVertices<T>(NativeArray<T> inVertices, int start, int length) where T : struct
	{
		SetVertices(inVertices, start, length, MeshUpdateFlags.Default);
	}

	public unsafe void SetVertices<T>(NativeArray<T> inVertices, int start, int length, [DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags) where T : struct
	{
		if (UnsafeUtility.SizeOf<T>() != 12)
		{
			throw new ArgumentException("SetVertices with NativeArray should use struct type that is 12 bytes (3x float) in size");
		}
		SetSizedNativeArrayForChannel(VertexAttribute.Position, VertexAttributeFormat.Float32, 3, (IntPtr)inVertices.GetUnsafeReadOnlyPtr(), inVertices.Length, start, length, flags);
	}

	public void GetNormals(List<Vector3> normals)
	{
		if (normals == null)
		{
			throw new ArgumentNullException("normals", "The result normals list cannot be null.");
		}
		GetListForChannel(normals, vertexCount, VertexAttribute.Normal, DefaultDimensionForChannel(VertexAttribute.Normal));
	}

	public void SetNormals(List<Vector3> inNormals)
	{
		SetNormals(inNormals, 0, NoAllocHelpers.SafeLength(inNormals));
	}

	[ExcludeFromDocs]
	public void SetNormals(List<Vector3> inNormals, int start, int length)
	{
		SetNormals(inNormals, start, length, MeshUpdateFlags.Default);
	}

	public void SetNormals(List<Vector3> inNormals, int start, int length, [DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags)
	{
		SetListForChannel(VertexAttribute.Normal, inNormals, start, length, flags);
	}

	public void SetNormals(Vector3[] inNormals)
	{
		SetNormals(inNormals, 0, NoAllocHelpers.SafeLength(inNormals));
	}

	[ExcludeFromDocs]
	public void SetNormals(Vector3[] inNormals, int start, int length)
	{
		SetNormals(inNormals, start, length, MeshUpdateFlags.Default);
	}

	public void SetNormals(Vector3[] inNormals, int start, int length, [DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags)
	{
		SetSizedArrayForChannel(VertexAttribute.Normal, VertexAttributeFormat.Float32, DefaultDimensionForChannel(VertexAttribute.Normal), inNormals, NoAllocHelpers.SafeLength(inNormals), start, length, flags);
	}

	public void SetNormals<T>(NativeArray<T> inNormals) where T : struct
	{
		SetNormals(inNormals, 0, inNormals.Length);
	}

	[ExcludeFromDocs]
	public void SetNormals<T>(NativeArray<T> inNormals, int start, int length) where T : struct
	{
		SetNormals(inNormals, start, length, MeshUpdateFlags.Default);
	}

	public unsafe void SetNormals<T>(NativeArray<T> inNormals, int start, int length, [DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags) where T : struct
	{
		if (UnsafeUtility.SizeOf<T>() != 12)
		{
			throw new ArgumentException("SetNormals with NativeArray should use struct type that is 12 bytes (3x float) in size");
		}
		SetSizedNativeArrayForChannel(VertexAttribute.Normal, VertexAttributeFormat.Float32, 3, (IntPtr)inNormals.GetUnsafeReadOnlyPtr(), inNormals.Length, start, length, flags);
	}

	public void GetTangents(List<Vector4> tangents)
	{
		if (tangents == null)
		{
			throw new ArgumentNullException("tangents", "The result tangents list cannot be null.");
		}
		GetListForChannel(tangents, vertexCount, VertexAttribute.Tangent, DefaultDimensionForChannel(VertexAttribute.Tangent));
	}

	public void SetTangents(List<Vector4> inTangents)
	{
		SetTangents(inTangents, 0, NoAllocHelpers.SafeLength(inTangents));
	}

	[ExcludeFromDocs]
	public void SetTangents(List<Vector4> inTangents, int start, int length)
	{
		SetTangents(inTangents, start, length, MeshUpdateFlags.Default);
	}

	public void SetTangents(List<Vector4> inTangents, int start, int length, [DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags)
	{
		SetListForChannel(VertexAttribute.Tangent, inTangents, start, length, flags);
	}

	public void SetTangents(Vector4[] inTangents)
	{
		SetTangents(inTangents, 0, NoAllocHelpers.SafeLength(inTangents));
	}

	[ExcludeFromDocs]
	public void SetTangents(Vector4[] inTangents, int start, int length)
	{
		SetTangents(inTangents, start, length, MeshUpdateFlags.Default);
	}

	public void SetTangents(Vector4[] inTangents, int start, int length, [DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags)
	{
		SetSizedArrayForChannel(VertexAttribute.Tangent, VertexAttributeFormat.Float32, DefaultDimensionForChannel(VertexAttribute.Tangent), inTangents, NoAllocHelpers.SafeLength(inTangents), start, length, flags);
	}

	public void SetTangents<T>(NativeArray<T> inTangents) where T : struct
	{
		SetTangents(inTangents, 0, inTangents.Length);
	}

	[ExcludeFromDocs]
	public void SetTangents<T>(NativeArray<T> inTangents, int start, int length) where T : struct
	{
		SetTangents(inTangents, start, length, MeshUpdateFlags.Default);
	}

	public unsafe void SetTangents<T>(NativeArray<T> inTangents, int start, int length, [DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags) where T : struct
	{
		if (UnsafeUtility.SizeOf<T>() != 16)
		{
			throw new ArgumentException("SetTangents with NativeArray should use struct type that is 16 bytes (4x float) in size");
		}
		SetSizedNativeArrayForChannel(VertexAttribute.Tangent, VertexAttributeFormat.Float32, 4, (IntPtr)inTangents.GetUnsafeReadOnlyPtr(), inTangents.Length, start, length, flags);
	}

	public void GetColors(List<Color> colors)
	{
		if (colors == null)
		{
			throw new ArgumentNullException("colors", "The result colors list cannot be null.");
		}
		GetListForChannel(colors, vertexCount, VertexAttribute.Color, DefaultDimensionForChannel(VertexAttribute.Color));
	}

	public void SetColors(List<Color> inColors)
	{
		SetColors(inColors, 0, NoAllocHelpers.SafeLength(inColors));
	}

	[ExcludeFromDocs]
	public void SetColors(List<Color> inColors, int start, int length)
	{
		SetColors(inColors, start, length, MeshUpdateFlags.Default);
	}

	public void SetColors(List<Color> inColors, int start, int length, [DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags)
	{
		SetListForChannel(VertexAttribute.Color, inColors, start, length, flags);
	}

	public void SetColors(Color[] inColors)
	{
		SetColors(inColors, 0, NoAllocHelpers.SafeLength(inColors));
	}

	[ExcludeFromDocs]
	public void SetColors(Color[] inColors, int start, int length)
	{
		SetColors(inColors, start, length, MeshUpdateFlags.Default);
	}

	public void SetColors(Color[] inColors, int start, int length, [DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags)
	{
		SetSizedArrayForChannel(VertexAttribute.Color, VertexAttributeFormat.Float32, DefaultDimensionForChannel(VertexAttribute.Color), inColors, NoAllocHelpers.SafeLength(inColors), start, length, flags);
	}

	public void GetColors(List<Color32> colors)
	{
		if (colors == null)
		{
			throw new ArgumentNullException("colors", "The result colors list cannot be null.");
		}
		GetListForChannel(colors, vertexCount, VertexAttribute.Color, 4, VertexAttributeFormat.UNorm8);
	}

	public void SetColors(List<Color32> inColors)
	{
		SetColors(inColors, 0, NoAllocHelpers.SafeLength(inColors));
	}

	[ExcludeFromDocs]
	public void SetColors(List<Color32> inColors, int start, int length)
	{
		SetColors(inColors, start, length, MeshUpdateFlags.Default);
	}

	public void SetColors(List<Color32> inColors, int start, int length, [DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags)
	{
		SetListForChannel(VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4, inColors, start, length, flags);
	}

	public void SetColors(Color32[] inColors)
	{
		SetColors(inColors, 0, NoAllocHelpers.SafeLength(inColors));
	}

	[ExcludeFromDocs]
	public void SetColors(Color32[] inColors, int start, int length)
	{
		SetColors(inColors, start, length, MeshUpdateFlags.Default);
	}

	public void SetColors(Color32[] inColors, int start, int length, [DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags)
	{
		SetSizedArrayForChannel(VertexAttribute.Color, VertexAttributeFormat.UNorm8, 4, inColors, NoAllocHelpers.SafeLength(inColors), start, length, flags);
	}

	public void SetColors<T>(NativeArray<T> inColors) where T : struct
	{
		SetColors(inColors, 0, inColors.Length);
	}

	[ExcludeFromDocs]
	public void SetColors<T>(NativeArray<T> inColors, int start, int length) where T : struct
	{
		SetColors(inColors, start, length, MeshUpdateFlags.Default);
	}

	public unsafe void SetColors<T>(NativeArray<T> inColors, int start, int length, [DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags) where T : struct
	{
		int num = UnsafeUtility.SizeOf<T>();
		if (num != 16 && num != 4)
		{
			throw new ArgumentException("SetColors with NativeArray should use struct type that is 16 bytes (4x float) or 4 bytes (4x unorm) in size");
		}
		SetSizedNativeArrayForChannel(VertexAttribute.Color, (num == 4) ? VertexAttributeFormat.UNorm8 : VertexAttributeFormat.Float32, 4, (IntPtr)inColors.GetUnsafeReadOnlyPtr(), inColors.Length, start, length, flags);
	}

	private void SetUvsImpl<T>(int uvIndex, int dim, List<T> uvs, int start, int length, MeshUpdateFlags flags)
	{
		if (uvIndex < 0 || uvIndex > 7)
		{
			Debug.LogError("The uv index is invalid. Must be in the range 0 to 7.");
		}
		else
		{
			SetListForChannel(GetUVChannel(uvIndex), VertexAttributeFormat.Float32, dim, uvs, start, length, flags);
		}
	}

	public void SetUVs(int channel, List<Vector2> uvs)
	{
		SetUVs(channel, uvs, 0, NoAllocHelpers.SafeLength(uvs));
	}

	public void SetUVs(int channel, List<Vector3> uvs)
	{
		SetUVs(channel, uvs, 0, NoAllocHelpers.SafeLength(uvs));
	}

	public void SetUVs(int channel, List<Vector4> uvs)
	{
		SetUVs(channel, uvs, 0, NoAllocHelpers.SafeLength(uvs));
	}

	[ExcludeFromDocs]
	public void SetUVs(int channel, List<Vector2> uvs, int start, int length)
	{
		SetUVs(channel, uvs, start, length, MeshUpdateFlags.Default);
	}

	public void SetUVs(int channel, List<Vector2> uvs, int start, int length, [DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags)
	{
		SetUvsImpl(channel, 2, uvs, start, length, flags);
	}

	[ExcludeFromDocs]
	public void SetUVs(int channel, List<Vector3> uvs, int start, int length)
	{
		SetUVs(channel, uvs, start, length, MeshUpdateFlags.Default);
	}

	public void SetUVs(int channel, List<Vector3> uvs, int start, int length, [DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags)
	{
		SetUvsImpl(channel, 3, uvs, start, length, flags);
	}

	[ExcludeFromDocs]
	public void SetUVs(int channel, List<Vector4> uvs, int start, int length)
	{
		SetUVs(channel, uvs, start, length, MeshUpdateFlags.Default);
	}

	public void SetUVs(int channel, List<Vector4> uvs, int start, int length, [DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags)
	{
		SetUvsImpl(channel, 4, uvs, start, length, flags);
	}

	private void SetUvsImpl(int uvIndex, int dim, Array uvs, int arrayStart, int arraySize, MeshUpdateFlags flags)
	{
		if (uvIndex < 0 || uvIndex > 7)
		{
			throw new ArgumentOutOfRangeException("uvIndex", uvIndex, "The uv index is invalid. Must be in the range 0 to 7.");
		}
		SetSizedArrayForChannel(GetUVChannel(uvIndex), VertexAttributeFormat.Float32, dim, uvs, NoAllocHelpers.SafeLength(uvs), arrayStart, arraySize, flags);
	}

	public void SetUVs(int channel, Vector2[] uvs)
	{
		SetUVs(channel, uvs, 0, NoAllocHelpers.SafeLength(uvs));
	}

	public void SetUVs(int channel, Vector3[] uvs)
	{
		SetUVs(channel, uvs, 0, NoAllocHelpers.SafeLength(uvs));
	}

	public void SetUVs(int channel, Vector4[] uvs)
	{
		SetUVs(channel, uvs, 0, NoAllocHelpers.SafeLength(uvs));
	}

	[ExcludeFromDocs]
	public void SetUVs(int channel, Vector2[] uvs, int start, int length)
	{
		SetUVs(channel, uvs, start, length, MeshUpdateFlags.Default);
	}

	public void SetUVs(int channel, Vector2[] uvs, int start, int length, [DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags)
	{
		SetUvsImpl(channel, 2, uvs, start, length, flags);
	}

	[ExcludeFromDocs]
	public void SetUVs(int channel, Vector3[] uvs, int start, int length)
	{
		SetUVs(channel, uvs, start, length, MeshUpdateFlags.Default);
	}

	public void SetUVs(int channel, Vector3[] uvs, int start, int length, [DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags)
	{
		SetUvsImpl(channel, 3, uvs, start, length, flags);
	}

	[ExcludeFromDocs]
	public void SetUVs(int channel, Vector4[] uvs, int start, int length)
	{
		SetUVs(channel, uvs, start, length, MeshUpdateFlags.Default);
	}

	public void SetUVs(int channel, Vector4[] uvs, int start, int length, [DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags)
	{
		SetUvsImpl(channel, 4, uvs, start, length, flags);
	}

	public void SetUVs<T>(int channel, NativeArray<T> uvs) where T : struct
	{
		SetUVs(channel, uvs, 0, uvs.Length);
	}

	[ExcludeFromDocs]
	public void SetUVs<T>(int channel, NativeArray<T> uvs, int start, int length) where T : struct
	{
		SetUVs(channel, uvs, start, length, MeshUpdateFlags.Default);
	}

	public unsafe void SetUVs<T>(int channel, NativeArray<T> uvs, int start, int length, [DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags) where T : struct
	{
		if (channel < 0 || channel > 7)
		{
			throw new ArgumentOutOfRangeException("channel", channel, "The uv index is invalid. Must be in the range 0 to 7.");
		}
		int num = UnsafeUtility.SizeOf<T>();
		if ((num & 3) != 0)
		{
			throw new ArgumentException("SetUVs with NativeArray should use struct type that is multiple of 4 bytes in size");
		}
		int num2 = num / 4;
		if (num2 < 1 || num2 > 4)
		{
			throw new ArgumentException("SetUVs with NativeArray should use struct type that is 1..4 floats in size");
		}
		SetSizedNativeArrayForChannel(GetUVChannel(channel), VertexAttributeFormat.Float32, num2, (IntPtr)uvs.GetUnsafeReadOnlyPtr(), uvs.Length, start, length, flags);
	}

	private void GetUVsImpl<T>(int uvIndex, List<T> uvs, int dim)
	{
		if (uvs == null)
		{
			throw new ArgumentNullException("uvs", "The result uvs list cannot be null.");
		}
		if (uvIndex < 0 || uvIndex > 7)
		{
			throw new IndexOutOfRangeException("The uv index is invalid. Must be in the range 0 to 7.");
		}
		GetListForChannel(uvs, vertexCount, GetUVChannel(uvIndex), dim);
	}

	public void GetUVs(int channel, List<Vector2> uvs)
	{
		GetUVsImpl(channel, uvs, 2);
	}

	public void GetUVs(int channel, List<Vector3> uvs)
	{
		GetUVsImpl(channel, uvs, 3);
	}

	public void GetUVs(int channel, List<Vector4> uvs)
	{
		GetUVsImpl(channel, uvs, 4);
	}

	public VertexAttributeDescriptor[] GetVertexAttributes()
	{
		return (VertexAttributeDescriptor[])GetVertexAttributesAlloc();
	}

	public int GetVertexAttributes(VertexAttributeDescriptor[] attributes)
	{
		return GetVertexAttributesArray(attributes);
	}

	public int GetVertexAttributes(List<VertexAttributeDescriptor> attributes)
	{
		return GetVertexAttributesList(attributes);
	}

	public void SetVertexBufferParams(int vertexCount, params VertexAttributeDescriptor[] attributes)
	{
		SetVertexBufferParamsFromArray(vertexCount, attributes);
	}

	public unsafe void SetVertexBufferParams(int vertexCount, NativeArray<VertexAttributeDescriptor> attributes)
	{
		SetVertexBufferParamsFromPtr(vertexCount, (IntPtr)attributes.GetUnsafeReadOnlyPtr(), attributes.Length);
	}

	public unsafe void SetVertexBufferData<T>(NativeArray<T> data, int dataStart, int meshBufferStart, int count, int stream = 0, MeshUpdateFlags flags = MeshUpdateFlags.Default) where T : struct
	{
		if (!canAccess)
		{
			throw new InvalidOperationException("Not allowed to access vertex data on mesh '" + base.name + "' (isReadable is false; Read/Write must be enabled in import settings)");
		}
		if (dataStart < 0 || meshBufferStart < 0 || count < 0 || dataStart + count > data.Length)
		{
			throw new ArgumentOutOfRangeException($"Bad start/count arguments (dataStart:{dataStart} meshBufferStart:{meshBufferStart} count:{count})");
		}
		InternalSetVertexBufferData(stream, (IntPtr)data.GetUnsafeReadOnlyPtr(), dataStart, meshBufferStart, count, UnsafeUtility.SizeOf<T>(), flags);
	}

	public void SetVertexBufferData<T>(T[] data, int dataStart, int meshBufferStart, int count, int stream = 0, MeshUpdateFlags flags = MeshUpdateFlags.Default) where T : struct
	{
		if (!canAccess)
		{
			throw new InvalidOperationException("Not allowed to access vertex data on mesh '" + base.name + "' (isReadable is false; Read/Write must be enabled in import settings)");
		}
		if (!UnsafeUtility.IsArrayBlittable(data))
		{
			throw new ArgumentException("Array passed to SetVertexBufferData must be blittable.\n" + UnsafeUtility.GetReasonForArrayNonBlittable(data));
		}
		if (dataStart < 0 || meshBufferStart < 0 || count < 0 || dataStart + count > data.Length)
		{
			throw new ArgumentOutOfRangeException($"Bad start/count arguments (dataStart:{dataStart} meshBufferStart:{meshBufferStart} count:{count})");
		}
		InternalSetVertexBufferDataFromArray(stream, data, dataStart, meshBufferStart, count, UnsafeUtility.SizeOf<T>(), flags);
	}

	public void SetVertexBufferData<T>(List<T> data, int dataStart, int meshBufferStart, int count, int stream = 0, MeshUpdateFlags flags = MeshUpdateFlags.Default) where T : struct
	{
		if (!canAccess)
		{
			throw new InvalidOperationException("Not allowed to access vertex data on mesh '" + base.name + "' (isReadable is false; Read/Write must be enabled in import settings)");
		}
		if (!UnsafeUtility.IsGenericListBlittable<T>())
		{
			throw new ArgumentException(string.Format("List<{0}> passed to {1} must be blittable.\n{2}", typeof(T), "SetVertexBufferData", UnsafeUtility.GetReasonForGenericListNonBlittable<T>()));
		}
		if (dataStart < 0 || meshBufferStart < 0 || count < 0 || dataStart + count > data.Count)
		{
			throw new ArgumentOutOfRangeException($"Bad start/count arguments (dataStart:{dataStart} meshBufferStart:{meshBufferStart} count:{count})");
		}
		InternalSetVertexBufferDataFromArray(stream, NoAllocHelpers.ExtractArrayFromList(data), dataStart, meshBufferStart, count, UnsafeUtility.SizeOf<T>(), flags);
	}

	public static MeshDataArray AcquireReadOnlyMeshData(Mesh mesh)
	{
		return new MeshDataArray(mesh);
	}

	public static MeshDataArray AcquireReadOnlyMeshData(Mesh[] meshes)
	{
		if (meshes == null)
		{
			throw new ArgumentNullException("meshes", "Mesh array is null");
		}
		return new MeshDataArray(meshes, meshes.Length);
	}

	public static MeshDataArray AcquireReadOnlyMeshData(List<Mesh> meshes)
	{
		if (meshes == null)
		{
			throw new ArgumentNullException("meshes", "Mesh list is null");
		}
		return new MeshDataArray(NoAllocHelpers.ExtractArrayFromListT(meshes), meshes.Count);
	}

	public static MeshDataArray AllocateWritableMeshData(int meshCount)
	{
		return new MeshDataArray(meshCount);
	}

	public static void ApplyAndDisposeWritableMeshData(MeshDataArray data, Mesh mesh, MeshUpdateFlags flags = MeshUpdateFlags.Default)
	{
		if (mesh == null)
		{
			throw new ArgumentNullException("mesh", "Mesh is null");
		}
		if (data.Length != 1)
		{
			throw new InvalidOperationException(string.Format("{0} length must be 1 to apply to one mesh, was {1}", "MeshDataArray", data.Length));
		}
		data.ApplyToMeshAndDispose(mesh, flags);
	}

	public static void ApplyAndDisposeWritableMeshData(MeshDataArray data, Mesh[] meshes, MeshUpdateFlags flags = MeshUpdateFlags.Default)
	{
		if (meshes == null)
		{
			throw new ArgumentNullException("meshes", "Mesh array is null");
		}
		if (data.Length != meshes.Length)
		{
			throw new InvalidOperationException(string.Format("{0} length ({1}) must match destination meshes array length ({2})", "MeshDataArray", data.Length, meshes.Length));
		}
		data.ApplyToMeshesAndDispose(meshes, flags);
	}

	public static void ApplyAndDisposeWritableMeshData(MeshDataArray data, List<Mesh> meshes, MeshUpdateFlags flags = MeshUpdateFlags.Default)
	{
		if (meshes == null)
		{
			throw new ArgumentNullException("meshes", "Mesh list is null");
		}
		if (data.Length != meshes.Count)
		{
			throw new InvalidOperationException(string.Format("{0} length ({1}) must match destination meshes list length ({2})", "MeshDataArray", data.Length, meshes.Count));
		}
		data.ApplyToMeshesAndDispose(NoAllocHelpers.ExtractArrayFromListT(meshes), flags);
	}

	public GraphicsBuffer GetVertexBuffer(int index)
	{
		if (this == null)
		{
			throw new NullReferenceException();
		}
		return GetVertexBufferImpl(index);
	}

	public GraphicsBuffer GetIndexBuffer()
	{
		if (this == null)
		{
			throw new NullReferenceException();
		}
		return GetIndexBufferImpl();
	}

	private void PrintErrorCantAccessIndices()
	{
		Debug.LogError($"Not allowed to access triangles/indices on mesh '{base.name}' (isReadable is false; Read/Write must be enabled in import settings)");
	}

	private bool CheckCanAccessSubmesh(int submesh, bool errorAboutTriangles)
	{
		if (!canAccess)
		{
			PrintErrorCantAccessIndices();
			return false;
		}
		if (submesh < 0 || submesh >= subMeshCount)
		{
			Debug.LogError(string.Format("Failed getting {0}. Submesh index is out of bounds.", errorAboutTriangles ? "triangles" : "indices"), this);
			return false;
		}
		return true;
	}

	private bool CheckCanAccessSubmeshTriangles(int submesh)
	{
		return CheckCanAccessSubmesh(submesh, errorAboutTriangles: true);
	}

	private bool CheckCanAccessSubmeshIndices(int submesh)
	{
		return CheckCanAccessSubmesh(submesh, errorAboutTriangles: false);
	}

	public int[] GetTriangles(int submesh)
	{
		return GetTriangles(submesh, applyBaseVertex: true);
	}

	public int[] GetTriangles(int submesh, [DefaultValue("true")] bool applyBaseVertex)
	{
		return CheckCanAccessSubmeshTriangles(submesh) ? GetTrianglesImpl(submesh, applyBaseVertex) : new int[0];
	}

	public void GetTriangles(List<int> triangles, int submesh)
	{
		GetTriangles(triangles, submesh, applyBaseVertex: true);
	}

	public void GetTriangles(List<int> triangles, int submesh, [DefaultValue("true")] bool applyBaseVertex)
	{
		if (triangles == null)
		{
			throw new ArgumentNullException("triangles", "The result triangles list cannot be null.");
		}
		if (submesh < 0 || submesh >= subMeshCount)
		{
			throw new IndexOutOfRangeException("Specified sub mesh is out of range. Must be greater or equal to 0 and less than subMeshCount.");
		}
		NoAllocHelpers.EnsureListElemCount(triangles, (int)(3 * GetTrianglesCountImpl(submesh)));
		GetTrianglesNonAllocImpl(NoAllocHelpers.ExtractArrayFromListT(triangles), submesh, applyBaseVertex);
	}

	public void GetTriangles(List<ushort> triangles, int submesh, bool applyBaseVertex = true)
	{
		if (triangles == null)
		{
			throw new ArgumentNullException("triangles", "The result triangles list cannot be null.");
		}
		if (submesh < 0 || submesh >= subMeshCount)
		{
			throw new IndexOutOfRangeException("Specified sub mesh is out of range. Must be greater or equal to 0 and less than subMeshCount.");
		}
		NoAllocHelpers.EnsureListElemCount(triangles, (int)(3 * GetTrianglesCountImpl(submesh)));
		GetTrianglesNonAllocImpl16(NoAllocHelpers.ExtractArrayFromListT(triangles), submesh, applyBaseVertex);
	}

	[ExcludeFromDocs]
	public int[] GetIndices(int submesh)
	{
		return GetIndices(submesh, applyBaseVertex: true);
	}

	public int[] GetIndices(int submesh, [DefaultValue("true")] bool applyBaseVertex)
	{
		return CheckCanAccessSubmeshIndices(submesh) ? GetIndicesImpl(submesh, applyBaseVertex) : new int[0];
	}

	[ExcludeFromDocs]
	public void GetIndices(List<int> indices, int submesh)
	{
		GetIndices(indices, submesh, applyBaseVertex: true);
	}

	public void GetIndices(List<int> indices, int submesh, [DefaultValue("true")] bool applyBaseVertex)
	{
		if (indices == null)
		{
			throw new ArgumentNullException("indices", "The result indices list cannot be null.");
		}
		if (submesh < 0 || submesh >= subMeshCount)
		{
			throw new IndexOutOfRangeException("Specified sub mesh is out of range. Must be greater or equal to 0 and less than subMeshCount.");
		}
		NoAllocHelpers.EnsureListElemCount(indices, (int)GetIndexCount(submesh));
		GetIndicesNonAllocImpl(NoAllocHelpers.ExtractArrayFromListT(indices), submesh, applyBaseVertex);
	}

	public void GetIndices(List<ushort> indices, int submesh, bool applyBaseVertex = true)
	{
		if (indices == null)
		{
			throw new ArgumentNullException("indices", "The result indices list cannot be null.");
		}
		if (submesh < 0 || submesh >= subMeshCount)
		{
			throw new IndexOutOfRangeException("Specified sub mesh is out of range. Must be greater or equal to 0 and less than subMeshCount.");
		}
		NoAllocHelpers.EnsureListElemCount(indices, (int)GetIndexCount(submesh));
		GetIndicesNonAllocImpl16(NoAllocHelpers.ExtractArrayFromListT(indices), submesh, applyBaseVertex);
	}

	public unsafe void SetIndexBufferData<T>(NativeArray<T> data, int dataStart, int meshBufferStart, int count, MeshUpdateFlags flags = MeshUpdateFlags.Default) where T : struct
	{
		if (!canAccess)
		{
			PrintErrorCantAccessIndices();
			return;
		}
		if (dataStart < 0 || meshBufferStart < 0 || count < 0 || dataStart + count > data.Length)
		{
			throw new ArgumentOutOfRangeException($"Bad start/count arguments (dataStart:{dataStart} meshBufferStart:{meshBufferStart} count:{count})");
		}
		InternalSetIndexBufferData((IntPtr)data.GetUnsafeReadOnlyPtr(), dataStart, meshBufferStart, count, UnsafeUtility.SizeOf<T>(), flags);
	}

	public void SetIndexBufferData<T>(T[] data, int dataStart, int meshBufferStart, int count, MeshUpdateFlags flags = MeshUpdateFlags.Default) where T : struct
	{
		if (!canAccess)
		{
			PrintErrorCantAccessIndices();
			return;
		}
		if (!UnsafeUtility.IsArrayBlittable(data))
		{
			throw new ArgumentException("Array passed to SetIndexBufferData must be blittable.\n" + UnsafeUtility.GetReasonForArrayNonBlittable(data));
		}
		if (dataStart < 0 || meshBufferStart < 0 || count < 0 || dataStart + count > data.Length)
		{
			throw new ArgumentOutOfRangeException($"Bad start/count arguments (dataStart:{dataStart} meshBufferStart:{meshBufferStart} count:{count})");
		}
		InternalSetIndexBufferDataFromArray(data, dataStart, meshBufferStart, count, UnsafeUtility.SizeOf<T>(), flags);
	}

	public void SetIndexBufferData<T>(List<T> data, int dataStart, int meshBufferStart, int count, MeshUpdateFlags flags = MeshUpdateFlags.Default) where T : struct
	{
		if (!canAccess)
		{
			PrintErrorCantAccessIndices();
			return;
		}
		if (!UnsafeUtility.IsGenericListBlittable<T>())
		{
			throw new ArgumentException(string.Format("List<{0}> passed to {1} must be blittable.\n{2}", typeof(T), "SetIndexBufferData", UnsafeUtility.GetReasonForGenericListNonBlittable<T>()));
		}
		if (dataStart < 0 || meshBufferStart < 0 || count < 0 || dataStart + count > data.Count)
		{
			throw new ArgumentOutOfRangeException($"Bad start/count arguments (dataStart:{dataStart} meshBufferStart:{meshBufferStart} count:{count})");
		}
		InternalSetIndexBufferDataFromArray(NoAllocHelpers.ExtractArrayFromList(data), dataStart, meshBufferStart, count, UnsafeUtility.SizeOf<T>(), flags);
	}

	public uint GetIndexStart(int submesh)
	{
		if (submesh < 0 || submesh >= subMeshCount)
		{
			throw new IndexOutOfRangeException("Specified sub mesh is out of range. Must be greater or equal to 0 and less than subMeshCount.");
		}
		return GetIndexStartImpl(submesh);
	}

	public uint GetIndexCount(int submesh)
	{
		if (submesh < 0 || submesh >= subMeshCount)
		{
			throw new IndexOutOfRangeException("Specified sub mesh is out of range. Must be greater or equal to 0 and less than subMeshCount.");
		}
		return GetIndexCountImpl(submesh);
	}

	public uint GetBaseVertex(int submesh)
	{
		if (submesh < 0 || submesh >= subMeshCount)
		{
			throw new IndexOutOfRangeException("Specified sub mesh is out of range. Must be greater or equal to 0 and less than subMeshCount.");
		}
		return GetBaseVertexImpl(submesh);
	}

	private void CheckIndicesArrayRange(int valuesLength, int start, int length)
	{
		if (start < 0)
		{
			throw new ArgumentOutOfRangeException("start", start, "Mesh indices array start can't be negative.");
		}
		if (length < 0)
		{
			throw new ArgumentOutOfRangeException("length", length, "Mesh indices array length can't be negative.");
		}
		if (start >= valuesLength && length != 0)
		{
			throw new ArgumentOutOfRangeException("start", start, "Mesh indices array start is outside of array size.");
		}
		if (start + length > valuesLength)
		{
			throw new ArgumentOutOfRangeException("length", start + length, "Mesh indices array start+count is outside of array size.");
		}
	}

	private void SetTrianglesImpl(int submesh, IndexFormat indicesFormat, Array triangles, int trianglesArrayLength, int start, int length, bool calculateBounds, int baseVertex)
	{
		CheckIndicesArrayRange(trianglesArrayLength, start, length);
		SetIndicesImpl(submesh, MeshTopology.Triangles, indicesFormat, triangles, start, length, calculateBounds, baseVertex);
	}

	[ExcludeFromDocs]
	public void SetTriangles(int[] triangles, int submesh)
	{
		SetTriangles(triangles, submesh, calculateBounds: true, 0);
	}

	[ExcludeFromDocs]
	public void SetTriangles(int[] triangles, int submesh, bool calculateBounds)
	{
		SetTriangles(triangles, submesh, calculateBounds, 0);
	}

	public void SetTriangles(int[] triangles, int submesh, [DefaultValue("true")] bool calculateBounds, [DefaultValue("0")] int baseVertex)
	{
		SetTriangles(triangles, 0, NoAllocHelpers.SafeLength(triangles), submesh, calculateBounds, baseVertex);
	}

	public void SetTriangles(int[] triangles, int trianglesStart, int trianglesLength, int submesh, bool calculateBounds = true, int baseVertex = 0)
	{
		if (CheckCanAccessSubmeshTriangles(submesh))
		{
			SetTrianglesImpl(submesh, IndexFormat.UInt32, triangles, NoAllocHelpers.SafeLength(triangles), trianglesStart, trianglesLength, calculateBounds, baseVertex);
		}
	}

	public void SetTriangles(ushort[] triangles, int submesh, bool calculateBounds = true, int baseVertex = 0)
	{
		SetTriangles(triangles, 0, NoAllocHelpers.SafeLength(triangles), submesh, calculateBounds, baseVertex);
	}

	public void SetTriangles(ushort[] triangles, int trianglesStart, int trianglesLength, int submesh, bool calculateBounds = true, int baseVertex = 0)
	{
		if (CheckCanAccessSubmeshTriangles(submesh))
		{
			SetTrianglesImpl(submesh, IndexFormat.UInt16, triangles, NoAllocHelpers.SafeLength(triangles), trianglesStart, trianglesLength, calculateBounds, baseVertex);
		}
	}

	[ExcludeFromDocs]
	public void SetTriangles(List<int> triangles, int submesh)
	{
		SetTriangles(triangles, submesh, calculateBounds: true, 0);
	}

	[ExcludeFromDocs]
	public void SetTriangles(List<int> triangles, int submesh, bool calculateBounds)
	{
		SetTriangles(triangles, submesh, calculateBounds, 0);
	}

	public void SetTriangles(List<int> triangles, int submesh, [DefaultValue("true")] bool calculateBounds, [DefaultValue("0")] int baseVertex)
	{
		SetTriangles(triangles, 0, NoAllocHelpers.SafeLength(triangles), submesh, calculateBounds, baseVertex);
	}

	public void SetTriangles(List<int> triangles, int trianglesStart, int trianglesLength, int submesh, bool calculateBounds = true, int baseVertex = 0)
	{
		if (CheckCanAccessSubmeshTriangles(submesh))
		{
			SetTrianglesImpl(submesh, IndexFormat.UInt32, NoAllocHelpers.ExtractArrayFromList(triangles), NoAllocHelpers.SafeLength(triangles), trianglesStart, trianglesLength, calculateBounds, baseVertex);
		}
	}

	public void SetTriangles(List<ushort> triangles, int submesh, bool calculateBounds = true, int baseVertex = 0)
	{
		SetTriangles(triangles, 0, NoAllocHelpers.SafeLength(triangles), submesh, calculateBounds, baseVertex);
	}

	public void SetTriangles(List<ushort> triangles, int trianglesStart, int trianglesLength, int submesh, bool calculateBounds = true, int baseVertex = 0)
	{
		if (CheckCanAccessSubmeshTriangles(submesh))
		{
			SetTrianglesImpl(submesh, IndexFormat.UInt16, NoAllocHelpers.ExtractArrayFromList(triangles), NoAllocHelpers.SafeLength(triangles), trianglesStart, trianglesLength, calculateBounds, baseVertex);
		}
	}

	[ExcludeFromDocs]
	public void SetIndices(int[] indices, MeshTopology topology, int submesh)
	{
		SetIndices(indices, topology, submesh, calculateBounds: true, 0);
	}

	[ExcludeFromDocs]
	public void SetIndices(int[] indices, MeshTopology topology, int submesh, bool calculateBounds)
	{
		SetIndices(indices, topology, submesh, calculateBounds, 0);
	}

	public void SetIndices(int[] indices, MeshTopology topology, int submesh, [DefaultValue("true")] bool calculateBounds, [DefaultValue("0")] int baseVertex)
	{
		SetIndices(indices, 0, NoAllocHelpers.SafeLength(indices), topology, submesh, calculateBounds, baseVertex);
	}

	public void SetIndices(int[] indices, int indicesStart, int indicesLength, MeshTopology topology, int submesh, bool calculateBounds = true, int baseVertex = 0)
	{
		if (CheckCanAccessSubmeshIndices(submesh))
		{
			CheckIndicesArrayRange(NoAllocHelpers.SafeLength(indices), indicesStart, indicesLength);
			SetIndicesImpl(submesh, topology, IndexFormat.UInt32, indices, indicesStart, indicesLength, calculateBounds, baseVertex);
		}
	}

	public void SetIndices(ushort[] indices, MeshTopology topology, int submesh, bool calculateBounds = true, int baseVertex = 0)
	{
		SetIndices(indices, 0, NoAllocHelpers.SafeLength(indices), topology, submesh, calculateBounds, baseVertex);
	}

	public void SetIndices(ushort[] indices, int indicesStart, int indicesLength, MeshTopology topology, int submesh, bool calculateBounds = true, int baseVertex = 0)
	{
		if (CheckCanAccessSubmeshIndices(submesh))
		{
			CheckIndicesArrayRange(NoAllocHelpers.SafeLength(indices), indicesStart, indicesLength);
			SetIndicesImpl(submesh, topology, IndexFormat.UInt16, indices, indicesStart, indicesLength, calculateBounds, baseVertex);
		}
	}

	public void SetIndices<T>(NativeArray<T> indices, MeshTopology topology, int submesh, bool calculateBounds = true, int baseVertex = 0) where T : struct
	{
		SetIndices(indices, 0, indices.Length, topology, submesh, calculateBounds, baseVertex);
	}

	public unsafe void SetIndices<T>(NativeArray<T> indices, int indicesStart, int indicesLength, MeshTopology topology, int submesh, bool calculateBounds = true, int baseVertex = 0) where T : struct
	{
		if (CheckCanAccessSubmeshIndices(submesh))
		{
			int num = UnsafeUtility.SizeOf<T>();
			if (num != 2 && num != 4)
			{
				throw new ArgumentException("SetIndices with NativeArray should use type is 2 or 4 bytes in size");
			}
			CheckIndicesArrayRange(indices.Length, indicesStart, indicesLength);
			SetIndicesNativeArrayImpl(submesh, topology, (num != 2) ? IndexFormat.UInt32 : IndexFormat.UInt16, (IntPtr)indices.GetUnsafeReadOnlyPtr(), indicesStart, indicesLength, calculateBounds, baseVertex);
		}
	}

	public void SetIndices(List<int> indices, MeshTopology topology, int submesh, bool calculateBounds = true, int baseVertex = 0)
	{
		SetIndices(indices, 0, NoAllocHelpers.SafeLength(indices), topology, submesh, calculateBounds, baseVertex);
	}

	public void SetIndices(List<int> indices, int indicesStart, int indicesLength, MeshTopology topology, int submesh, bool calculateBounds = true, int baseVertex = 0)
	{
		if (CheckCanAccessSubmeshIndices(submesh))
		{
			Array indices2 = NoAllocHelpers.ExtractArrayFromList(indices);
			CheckIndicesArrayRange(NoAllocHelpers.SafeLength(indices), indicesStart, indicesLength);
			SetIndicesImpl(submesh, topology, IndexFormat.UInt32, indices2, indicesStart, indicesLength, calculateBounds, baseVertex);
		}
	}

	public void SetIndices(List<ushort> indices, MeshTopology topology, int submesh, bool calculateBounds = true, int baseVertex = 0)
	{
		SetIndices(indices, 0, NoAllocHelpers.SafeLength(indices), topology, submesh, calculateBounds, baseVertex);
	}

	public void SetIndices(List<ushort> indices, int indicesStart, int indicesLength, MeshTopology topology, int submesh, bool calculateBounds = true, int baseVertex = 0)
	{
		if (CheckCanAccessSubmeshIndices(submesh))
		{
			Array indices2 = NoAllocHelpers.ExtractArrayFromList(indices);
			CheckIndicesArrayRange(NoAllocHelpers.SafeLength(indices), indicesStart, indicesLength);
			SetIndicesImpl(submesh, topology, IndexFormat.UInt16, indices2, indicesStart, indicesLength, calculateBounds, baseVertex);
		}
	}

	public void SetSubMeshes(SubMeshDescriptor[] desc, int start, int count, MeshUpdateFlags flags = MeshUpdateFlags.Default)
	{
		if (count > 0 && desc == null)
		{
			throw new ArgumentNullException("desc", "Array of submeshes cannot be null unless count is zero.");
		}
		int num = ((desc != null) ? desc.Length : 0);
		if (start < 0 || count < 0 || start + count > num)
		{
			throw new ArgumentOutOfRangeException($"Bad start/count arguments (start:{start} count:{count} desc.Length:{num})");
		}
		for (int i = start; i < start + count; i++)
		{
			MeshTopology topology = desc[i].topology;
			if (topology < MeshTopology.Triangles || topology > MeshTopology.Points)
			{
				throw new ArgumentException("desc", $"{i}-th submesh descriptor has invalid topology ({(int)topology}).");
			}
			if (topology == (MeshTopology)1)
			{
				throw new ArgumentException("desc", $"{i}-th submesh descriptor has triangles strip topology, which is no longer supported.");
			}
		}
		SetAllSubMeshesAtOnceFromArray(desc, start, count, flags);
	}

	public void SetSubMeshes(SubMeshDescriptor[] desc, MeshUpdateFlags flags = MeshUpdateFlags.Default)
	{
		SetSubMeshes(desc, 0, (desc != null) ? desc.Length : 0, flags);
	}

	public void SetSubMeshes(List<SubMeshDescriptor> desc, int start, int count, MeshUpdateFlags flags = MeshUpdateFlags.Default)
	{
		SetSubMeshes(NoAllocHelpers.ExtractArrayFromListT(desc), start, count, flags);
	}

	public void SetSubMeshes(List<SubMeshDescriptor> desc, MeshUpdateFlags flags = MeshUpdateFlags.Default)
	{
		SetSubMeshes(NoAllocHelpers.ExtractArrayFromListT(desc), 0, desc?.Count ?? 0, flags);
	}

	public unsafe void SetSubMeshes<T>(NativeArray<T> desc, int start, int count, MeshUpdateFlags flags = MeshUpdateFlags.Default) where T : struct
	{
		if (UnsafeUtility.SizeOf<T>() != UnsafeUtility.SizeOf<SubMeshDescriptor>())
		{
			throw new ArgumentException(string.Format("{0} with NativeArray should use struct type that is {1} bytes in size", "SetSubMeshes", UnsafeUtility.SizeOf<SubMeshDescriptor>()));
		}
		if (start < 0 || count < 0 || start + count > desc.Length)
		{
			throw new ArgumentOutOfRangeException($"Bad start/count arguments (start:{start} count:{count} desc.Length:{desc.Length})");
		}
		SetAllSubMeshesAtOnceFromNativeArray((IntPtr)desc.GetUnsafeReadOnlyPtr(), start, count, flags);
	}

	public void SetSubMeshes<T>(NativeArray<T> desc, MeshUpdateFlags flags = MeshUpdateFlags.Default) where T : struct
	{
		SetSubMeshes(desc, 0, desc.Length, flags);
	}

	public void GetBindposes(List<Matrix4x4> bindposes)
	{
		if (bindposes == null)
		{
			throw new ArgumentNullException("bindposes", "The result bindposes list cannot be null.");
		}
		NoAllocHelpers.EnsureListElemCount(bindposes, GetBindposeCount());
		GetBindposesNonAllocImpl(NoAllocHelpers.ExtractArrayFromListT(bindposes));
	}

	public void GetBoneWeights(List<BoneWeight> boneWeights)
	{
		if (boneWeights == null)
		{
			throw new ArgumentNullException("boneWeights", "The result boneWeights list cannot be null.");
		}
		if (HasBoneWeights())
		{
			NoAllocHelpers.EnsureListElemCount(boneWeights, vertexCount);
		}
		GetBoneWeightsNonAllocImpl(NoAllocHelpers.ExtractArrayFromListT(boneWeights));
	}

	public void Clear([DefaultValue("true")] bool keepVertexLayout)
	{
		ClearImpl(keepVertexLayout);
	}

	[ExcludeFromDocs]
	public void Clear()
	{
		ClearImpl(keepVertexLayout: true);
	}

	[ExcludeFromDocs]
	public void RecalculateBounds()
	{
		RecalculateBounds(MeshUpdateFlags.Default);
	}

	[ExcludeFromDocs]
	public void RecalculateNormals()
	{
		RecalculateNormals(MeshUpdateFlags.Default);
	}

	[ExcludeFromDocs]
	public void RecalculateTangents()
	{
		RecalculateTangents(MeshUpdateFlags.Default);
	}

	public void RecalculateBounds([DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags)
	{
		if (canAccess)
		{
			RecalculateBoundsImpl(flags);
		}
		else
		{
			Debug.LogError($"Not allowed to call RecalculateBounds() on mesh '{base.name}'");
		}
	}

	public void RecalculateNormals([DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags)
	{
		if (canAccess)
		{
			RecalculateNormalsImpl(flags);
		}
		else
		{
			Debug.LogError($"Not allowed to call RecalculateNormals() on mesh '{base.name}'");
		}
	}

	public void RecalculateTangents([DefaultValue("MeshUpdateFlags.Default")] MeshUpdateFlags flags)
	{
		if (canAccess)
		{
			RecalculateTangentsImpl(flags);
		}
		else
		{
			Debug.LogError($"Not allowed to call RecalculateTangents() on mesh '{base.name}'");
		}
	}

	public void RecalculateUVDistributionMetric(int uvSetIndex, float uvAreaThreshold = 1E-09f)
	{
		if (canAccess)
		{
			RecalculateUVDistributionMetricImpl(uvSetIndex, uvAreaThreshold);
		}
		else
		{
			Debug.LogError($"Not allowed to call RecalculateUVDistributionMetric() on mesh '{base.name}'");
		}
	}

	public void RecalculateUVDistributionMetrics(float uvAreaThreshold = 1E-09f)
	{
		if (canAccess)
		{
			RecalculateUVDistributionMetricsImpl(uvAreaThreshold);
		}
		else
		{
			Debug.LogError($"Not allowed to call RecalculateUVDistributionMetrics() on mesh '{base.name}'");
		}
	}

	public void MarkDynamic()
	{
		if (canAccess)
		{
			MarkDynamicImpl();
		}
	}

	public void UploadMeshData(bool markNoLongerReadable)
	{
		if (canAccess)
		{
			UploadMeshDataImpl(markNoLongerReadable);
		}
	}

	public void Optimize()
	{
		if (canAccess)
		{
			OptimizeImpl();
		}
		else
		{
			Debug.LogError($"Not allowed to call Optimize() on mesh '{base.name}'");
		}
	}

	public void OptimizeIndexBuffers()
	{
		if (canAccess)
		{
			OptimizeIndexBuffersImpl();
		}
		else
		{
			Debug.LogError($"Not allowed to call OptimizeIndexBuffers() on mesh '{base.name}'");
		}
	}

	public void OptimizeReorderVertexBuffer()
	{
		if (canAccess)
		{
			OptimizeReorderVertexBufferImpl();
		}
		else
		{
			Debug.LogError($"Not allowed to call OptimizeReorderVertexBuffer() on mesh '{base.name}'");
		}
	}

	public MeshTopology GetTopology(int submesh)
	{
		if (submesh < 0 || submesh >= subMeshCount)
		{
			Debug.LogError("Failed getting topology. Submesh index is out of bounds.", this);
			return MeshTopology.Triangles;
		}
		return GetTopologyImpl(submesh);
	}

	public void CombineMeshes(CombineInstance[] combine, [DefaultValue("true")] bool mergeSubMeshes, [DefaultValue("true")] bool useMatrices, [DefaultValue("false")] bool hasLightmapData)
	{
		CombineMeshesImpl(combine, mergeSubMeshes, useMatrices, hasLightmapData);
	}

	[ExcludeFromDocs]
	public void CombineMeshes(CombineInstance[] combine, bool mergeSubMeshes, bool useMatrices)
	{
		CombineMeshesImpl(combine, mergeSubMeshes, useMatrices, hasLightmapData: false);
	}

	[ExcludeFromDocs]
	public void CombineMeshes(CombineInstance[] combine, bool mergeSubMeshes)
	{
		CombineMeshesImpl(combine, mergeSubMeshes, useMatrices: true, hasLightmapData: false);
	}

	[ExcludeFromDocs]
	public void CombineMeshes(CombineInstance[] combine)
	{
		CombineMeshesImpl(combine, mergeSubMeshes: true, useMatrices: true, hasLightmapData: false);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetVertexAttribute_Injected(int index, out VertexAttributeDescriptor ret);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void SetSubMesh_Injected(int index, ref SubMeshDescriptor desc, MeshUpdateFlags flags = MeshUpdateFlags.Default);

	[MethodImpl((MethodImplOptions)4096)]
	private extern void GetSubMesh_Injected(int index, out SubMeshDescriptor ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_bounds_Injected(out Bounds ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void set_bounds_Injected(ref Bounds value);
}
