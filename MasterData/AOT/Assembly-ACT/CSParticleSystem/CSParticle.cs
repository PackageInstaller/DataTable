using UnityEngine;
using UnityEngine.Rendering;

namespace CSParticleSystem;

public class CSParticle
{
	private struct ParticleData
	{
		public Vector3 position;

		public Vector3 velocity;

		public Vector3 rotation;

		public Vector3 rotationSpeed;

		public float scale;

		public float lifeTime;

		public float age;

		public float cameraDepth;
	}

	private struct SortingData
	{
		private float cameraDepth;

		private int bufferIndex;
	}

	private struct ComputeBufferStack
	{
		public ComputeBuffer spawBuffer;

		public ComputeBuffer aliveBuffer;
	}

	private struct SystemData
	{
		private int needSimCount;

		private int sortingRound;
	}

	public class ExtraBufferData
	{
		public string name;

		public ComputeBuffer buffer;

		public ExtraBufferData(string bufferName, ComputeBuffer inputBuffer)
		{
			name = bufferName;
			buffer = inputBuffer;
		}
	}

	public class IntData
	{
		public bool needSorting;

		public bool needClip;

		public Camera ClipCamera;

		public bool worldParticle;

		public IntData(bool m_needSorting, bool m_needClip, Camera m_ClipCamera, bool m_worldParticle)
		{
			needSorting = m_needSorting;
			needClip = m_needClip;
			ClipCamera = m_ClipCamera;
			worldParticle = m_worldParticle;
		}
	}

	private Vector4 randomData;

	private Vector4 baseData;

	private int particleUpdateKernelIndex;

	private int particleSpawnKernelIndex;

	private int particleSortingKernelIndex;

	private int particleSortingKernelIndex2;

	private int particleCopyBufferKernel;

	private int particleClipKernel;

	private ComputeBuffer particleBuffer;

	private ComputeBuffer particleBuffer2;

	private ComputeBuffer customDataBuffer;

	private ComputeBuffer customDataBuffer2;

	private ComputeBufferStack bufferStack;

	private ComputeBufferStack customStack;

	private ComputeBuffer argsBuffer;

	private ComputeBuffer systemBuffer;

	private ComputeBuffer sortDataBuffer;

	private ComputeBuffer clipBuffer;

	private ComputeBuffer drawBuffer;

	private ComputeBuffer customDrawBuffer;

	private ComputeBuffer particleBufferToDraw;

	private ComputeBuffer customBufferToDraw;

	private uint[] argsData;

	private ParticleData[] particleData;

	private int MaxParticleCount;

	private bool needSpaw;

	private float spawPreSecond;

	private int particleCountCatch;

	private bool isParticleDataDirty;

	private bool needRefreshBuffer;

	private bool idArgsBufferInitialized;

	private Mesh instanceMesh;

	private int submeshIndex;

	private Material drawMat;

	private Transform parentTransform;

	private bool needSort;

	private float spawCalculate;

	private int spawCountForcibly;

	private bool needSpawForcibly;

	private CommandBuffer cmd;

	private bool needCustomData;

	private bool needClip;

	private Camera clipCamera;

	private bool isWorldParticle;

	private LocalKeyword WorldParticleKey;

	private LocalKeyword WorldParticleCSKey;

	private LocalKeyword NeedSortingKey;

	private LocalKeyword CustomDataKey;

	private Plane[] cameraPlanes;

	private static int CameraPlaneTag0 = Shader.PropertyToID("_CameraPlane0CS");

	private static int CameraPlaneTag1 = Shader.PropertyToID("_CameraPlane1CS");

	private static int CameraPlaneTag2 = Shader.PropertyToID("_CameraPlane2CS");

	private static int CameraPlaneTag3 = Shader.PropertyToID("_CameraPlane3CS");

	private static int CameraPlaneTag4 = Shader.PropertyToID("_CameraPlane4CS");

	private static int CameraPlaneTag5 = Shader.PropertyToID("_CameraPlane5CS");

	private static int[] planeTagList = new int[6] { CameraPlaneTag0, CameraPlaneTag1, CameraPlaneTag2, CameraPlaneTag3, CameraPlaneTag4, CameraPlaneTag5 };

	private ComputeShader particleCS { get; set; }

	private ComputeShader spawCS { get; set; }

	private ComputeShader simulateCS { get; set; }

	public void setRotateRandom(float rotateRandom)
	{
		randomData.x = rotateRandom;
		setPartialDataDirty();
	}

	public void setSizeRandom(float sizeRandom)
	{
		randomData.z = sizeRandom;
		setPartialDataDirty();
	}

	public void setSpeedRandom(float speedRandom)
	{
		randomData.y = speedRandom;
		setPartialDataDirty();
	}

	public void setLifeTimeRandom(float lightTimeRandom)
	{
		randomData.w = lightTimeRandom;
		setPartialDataDirty();
	}

	public void setBaseSize(float baseSize)
	{
		baseData.z = baseSize;
		setPartialDataDirty();
	}

	public void setBaseSpeed(float baseSpeed)
	{
		baseData.y = baseSpeed;
		setPartialDataDirty();
	}

	public void setBaseRotationSpeed(float baseRotationSpeed)
	{
		baseData.x = baseRotationSpeed;
		setPartialDataDirty();
	}

	public void setBaseLifeTime(float baseLifeTime)
	{
		baseData.w = baseLifeTime;
		setPartialDataDirty();
	}

	private void refreshCSMaxParticleCount()
	{
		particleCS.SetInt("_maxParticleCount", MaxParticleCount);
		spawCS.SetInt("_maxParticleCount", MaxParticleCount);
		simulateCS.SetInt("_maxParticleCount", MaxParticleCount);
	}

	private void setPartialDataDirty()
	{
		isParticleDataDirty = true;
	}

	private void refreshCSParticleParam()
	{
		cmd.SetComputeVectorParam(spawCS, "_particleRandomData", randomData);
		cmd.SetComputeVectorParam(spawCS, "_particleBaseData", baseData);
		isParticleDataDirty = false;
	}

	private void refreshParticleSystemData()
	{
		if (isParticleDataDirty)
		{
			refreshCSParticleParam();
		}
		cmd.SetComputeVectorParam(spawCS, "_TimeData", new Vector4(Time.deltaTime, Time.time, 0f, 0f));
		cmd.SetComputeVectorParam(simulateCS, "_TimeData", new Vector4(Time.deltaTime, Time.time, 0f, 0f));
	}

	private void refreshCountCatch()
	{
		particleCountCatch = MaxParticleCount;
	}

	public void refreshMaxParticleCount(int count)
	{
		MaxParticleCount = count;
	}

	private void swapBuffer(ref ComputeBufferStack stackInpute)
	{
		ref ComputeBuffer spawBuffer = ref stackInpute.spawBuffer;
		ref ComputeBuffer aliveBuffer = ref stackInpute.aliveBuffer;
		ComputeBuffer aliveBuffer2 = stackInpute.aliveBuffer;
		ComputeBuffer spawBuffer2 = stackInpute.spawBuffer;
		spawBuffer = aliveBuffer2;
		aliveBuffer = spawBuffer2;
	}

	public void setSpawPreSecond(float spawSpeed)
	{
		spawPreSecond = spawSpeed;
	}

	public CSParticle(int maxParticleCount, float spawSpeed, ComputeShader baseCs, ComputeShader simulateParticleCS, ComputeShader spawParticleCS, Transform trans, IntData intData)
		: this(maxParticleCount, spawSpeed, baseCs, simulateParticleCS, spawParticleCS, trans, 16, customData: false, 8, intData, null)
	{
	}

	public CSParticle(int maxParticleCount, float spawSpeed, ComputeShader baseCs, ComputeShader simulateParticleCS, ComputeShader spawParticleCS, Transform trans, IntData intData, ExtraBufferData extraBufferData)
		: this(maxParticleCount, spawSpeed, baseCs, simulateParticleCS, spawParticleCS, trans, 16, customData: false, 8, intData, extraBufferData)
	{
	}

	public CSParticle(int maxParticleCount, float spawSpeed, ComputeShader baseCs, ComputeShader simulateParticleCS, ComputeShader spawParticleCS, Transform trans, bool customData, IntData intData, ExtraBufferData extraBufferData)
		: this(maxParticleCount, spawSpeed, baseCs, simulateParticleCS, spawParticleCS, trans, 16, customData, 8, intData, extraBufferData)
	{
	}

	public CSParticle(int maxParticleCount, float spawSpeed, ComputeShader baseCs, ComputeShader simulateParticleCS, ComputeShader spawParticleCS, Transform trans, int particleBufferBit, bool customData, int customBit, IntData intData, ExtraBufferData extraBufferData)
	{
		cmd = new CommandBuffer();
		cmd.name = "CSParticalSim";
		cameraPlanes = new Plane[6];
		needCustomData = customData;
		if (intData.ClipCamera != null && intData.needClip)
		{
			needClip = true;
		}
		else
		{
			needClip = false;
			clipCamera = null;
		}
		if (intData.ClipCamera != null)
		{
			clipCamera = intData.ClipCamera;
		}
		if (intData.needSorting && intData.ClipCamera != null)
		{
			needSort = true;
		}
		else
		{
			needSort = false;
		}
		isWorldParticle = intData.worldParticle;
		NeedSortingKey = new LocalKeyword(baseCs, "_USE_SORTING");
		WorldParticleCSKey = new LocalKeyword(baseCs, "_USE_WORLD");
		CustomDataKey = new LocalKeyword(baseCs, "_USE_CUSTOMDATA");
		particleCS = baseCs;
		simulateCS = simulateParticleCS;
		spawCS = spawParticleCS;
		parentTransform = trans;
		particleUpdateKernelIndex = simulateCS.FindKernel("ParticleUpdate");
		particleSpawnKernelIndex = spawCS.FindKernel("ParticleSpawn");
		particleSortingKernelIndex = particleCS.FindKernel("ParticleSorting");
		particleSortingKernelIndex2 = particleCS.FindKernel("ParticleSorting2");
		particleCopyBufferKernel = particleCS.FindKernel("CopyBuffer");
		particleClipKernel = particleCS.FindKernel("ClipParticle");
		spawPreSecond = spawSpeed;
		MaxParticleCount = maxParticleCount;
		refreshCountCatch();
		refreshCSMaxParticleCount();
		particleBuffer = new ComputeBuffer(MaxParticleCount, particleBufferBit * 4, ComputeBufferType.Append);
		particleBuffer.SetCounterValue(0u);
		particleBuffer2 = new ComputeBuffer(MaxParticleCount, particleBufferBit * 4, ComputeBufferType.Append);
		particleBuffer2.SetCounterValue(0u);
		if (needSort || needClip)
		{
			if (customData)
			{
				customDrawBuffer = new ComputeBuffer(maxParticleCount, customBit * 4);
			}
			else
			{
				customDrawBuffer = new ComputeBuffer(1, customBit * 4);
			}
			drawBuffer = new ComputeBuffer(maxParticleCount, particleBufferBit * 4);
		}
		if (customData)
		{
			customDataBuffer = new ComputeBuffer(MaxParticleCount, customBit * 4, ComputeBufferType.Append);
			customDataBuffer.SetCounterValue(0u);
			customDataBuffer2 = new ComputeBuffer(MaxParticleCount, customBit * 4, ComputeBufferType.Append);
			customDataBuffer.SetCounterValue(0u);
			baseCs.SetKeyword(in CustomDataKey, value: true);
		}
		else
		{
			customDataBuffer = new ComputeBuffer(1, customBit * 4, ComputeBufferType.Append);
			customDataBuffer.SetCounterValue(0u);
			customDataBuffer2 = new ComputeBuffer(1, customBit * 4, ComputeBufferType.Append);
			customDataBuffer.SetCounterValue(0u);
		}
		customStack = default;
		customStack.spawBuffer = customDataBuffer;
		customStack.aliveBuffer = customDataBuffer2;
		if (needClip)
		{
			clipBuffer = new ComputeBuffer(maxParticleCount, 4, ComputeBufferType.Append);
		}
		else
		{
			clipBuffer = new ComputeBuffer(1, 4, ComputeBufferType.Append);
		}
		systemBuffer = new ComputeBuffer(1, 8, ComputeBufferType.DrawIndirect);
		bufferStack = default;
		bufferStack.spawBuffer = particleBuffer;
		bufferStack.aliveBuffer = particleBuffer2;
		argsData = new uint[5];
		argsBuffer = new ComputeBuffer(5, argsData.Length * 4, ComputeBufferType.DrawIndirect);
		argsBuffer.SetData(argsData);
		if (needSort)
		{
			baseCs.SetKeyword(in NeedSortingKey, value: true);
			sortDataBuffer = new ComputeBuffer(MaxParticleCount, 8);
		}
		if (isWorldParticle)
		{
			baseCs.SetKeyword(in WorldParticleCSKey, value: true);
		}
		simulateCS.SetBuffer(particleUpdateKernelIndex, "_systemBuffer", systemBuffer);
		spawCS.SetBuffer(particleSpawnKernelIndex, "_systemBuffer", systemBuffer);
		if (extraBufferData != null && extraBufferData.buffer != null)
		{
			simulateCS.SetBuffer(particleUpdateKernelIndex, extraBufferData.name, extraBufferData.buffer);
			spawCS.SetBuffer(particleSpawnKernelIndex, extraBufferData.name, extraBufferData.buffer);
		}
		spawCalculate = 0f;
	}

	public void changeSpawCS(ComputeShader spawCs)
	{
		spawCS = spawCs;
		particleSpawnKernelIndex = spawCS.FindKernel("ParticleSpaw");
		cmd.SetComputeIntParam(spawCS, "_maxParticleCount", MaxParticleCount);
		spawCS.SetBuffer(particleSpawnKernelIndex, "_systemBuffer", systemBuffer);
	}

	public void changeSimulateCS(ComputeShader simCs)
	{
		simulateCS = simCs;
		particleUpdateKernelIndex = simulateCS.FindKernel("ParticleUpdate");
		cmd.SetComputeIntParam(simulateCS, "_maxParticleCount", MaxParticleCount);
		simulateCS.SetBuffer(particleUpdateKernelIndex, "_systemBuffer", systemBuffer);
	}

	private void SpawParticle()
	{
		swapBuffer(ref bufferStack);
		if (needCustomData)
		{
			swapBuffer(ref customStack);
		}
		float num = spawPreSecond * Time.deltaTime;
		spawCalculate += num;
		if (spawCalculate >= 1f)
		{
			num = Mathf.CeilToInt(spawPreSecond * Time.deltaTime);
			spawParticleIndirect((int)num);
		}
		spawCalculate %= 1f;
	}

	private void SimulateParticle()
	{
		if (needSort)
		{
			Transform transform = clipCamera.transform;
			if (isWorldParticle)
			{
				cmd.SetComputeVectorParam(simulateCS, "_CSP_cameraPosOS", new Vector4(transform.position.x, transform.position.y, transform.position.z, 1f));
				cmd.SetComputeVectorParam(simulateCS, "_CSP_cameraDirOS", new Vector4(transform.forward.x, transform.forward.y, transform.forward.z, 0f));
			}
			else
			{
				cmd.SetComputeVectorParam(simulateCS, "_CSP_cameraPosOS", parentTransform.worldToLocalMatrix * new Vector4(transform.position.x, transform.position.y, transform.position.z, 1f));
				cmd.SetComputeVectorParam(simulateCS, "_CSP_cameraDirOS", parentTransform.worldToLocalMatrix * new Vector4(transform.forward.x, transform.forward.y, transform.forward.z, 0f));
			}
		}
		cmd.SetBufferCounterValue(bufferStack.aliveBuffer, 0u);
		cmd.SetComputeBufferParam(simulateCS, particleUpdateKernelIndex, "_particleDataInput", bufferStack.spawBuffer);
		cmd.SetComputeBufferParam(simulateCS, particleUpdateKernelIndex, "_particleDataOutput", bufferStack.aliveBuffer);
		if (needCustomData)
		{
			cmd.SetBufferCounterValue(customStack.aliveBuffer, 0u);
			cmd.SetComputeBufferParam(simulateCS, particleUpdateKernelIndex, "_customDataInput", customStack.spawBuffer);
			cmd.SetComputeBufferParam(simulateCS, particleUpdateKernelIndex, "_customDataOutput", customStack.aliveBuffer);
			cmd.SetComputeIntParam(simulateCS, "_useCustom", 1);
		}
		cmd.DispatchCompute(simulateCS, particleUpdateKernelIndex, Mathf.CeilToInt((float)MaxParticleCount / 64f), 1, 1);
		cmd.CopyCounterValue(bufferStack.aliveBuffer, systemBuffer, 0u);
	}

	private void spawParticleIndirect(int count)
	{
		cmd.SetComputeBufferParam(spawCS, particleSpawnKernelIndex, "_particleDataSpaw", bufferStack.spawBuffer);
		if (needCustomData)
		{
			cmd.SetComputeBufferParam(spawCS, particleSpawnKernelIndex, "_customDataSpaw", customStack.spawBuffer);
		}
		cmd.SetComputeIntParam(spawCS, "_spawCount", count);
		cmd.DispatchCompute(spawCS, particleSpawnKernelIndex, Mathf.Max(1, Mathf.CeilToInt((float)count / 64f)), 1, 1);
		cmd.CopyCounterValue(bufferStack.spawBuffer, systemBuffer, 0u);
	}

	public void spawForcibly(int count)
	{
		needSpawForcibly = true;
		spawCountForcibly = count;
	}

	public void updateParticle()
	{
		cmd.Clear();
		refreshParticleSystemData();
		SpawParticle();
		if (needSpawForcibly)
		{
			spawParticleIndirect(spawCountForcibly);
			needSpawForcibly = false;
		}
		SimulateParticle();
		if (needSort || needClip)
		{
			if (needCustomData)
			{
				customBufferToDraw = customDrawBuffer;
			}
			particleBufferToDraw = drawBuffer;
		}
		else
		{
			particleBufferToDraw = bufferStack.aliveBuffer;
			if (needCustomData)
			{
				customBufferToDraw = customStack.aliveBuffer;
			}
		}
		if (needClip)
		{
			particleClip();
		}
		if (needSort)
		{
			sortingParticle();
		}
		if (needSort || needClip)
		{
			copyBuffer();
		}
		Graphics.ExecuteCommandBuffer(cmd);
	}

	public ComputeBuffer getParticleBuffer()
	{
		return particleBufferToDraw;
	}

	public ComputeBuffer getCustomBuffer()
	{
		return customBufferToDraw;
	}

	private void updateArgsBuffer()
	{
		cmd.Clear();
		if (!needClip)
		{
			cmd.CopyCounterValue(bufferStack.aliveBuffer, argsBuffer, 4u);
		}
		else
		{
			cmd.CopyCounterValue(clipBuffer, argsBuffer, 4u);
		}
		Graphics.ExecuteCommandBuffer(cmd);
	}

	private void initializeArgsBuffer()
	{
		argsData[0] = instanceMesh.GetIndexCount(submeshIndex);
		argsData[1] = (uint)MaxParticleCount;
		argsData[2] = instanceMesh.GetIndexStart(submeshIndex);
		argsData[3] = instanceMesh.GetBaseVertex(submeshIndex);
		argsData[4] = 0u;
		argsBuffer.SetData(argsData);
	}

	public void drawParticleInstance(Bounds bound)
	{
		updateArgsBuffer();
		if ((bool)drawMat)
		{
			WorldParticleKey = new LocalKeyword(drawMat.shader, "_USE_WORLD");
			if (isWorldParticle)
			{
				drawMat.SetKeyword(in WorldParticleKey, value: true);
			}
			else
			{
				drawMat.SetKeyword(in WorldParticleKey, value: false);
			}
			drawMat.SetBuffer("_particleData", particleBufferToDraw);
			if (needCustomData)
			{
				drawMat.SetBuffer("_customData", particleBufferToDraw);
			}
			Graphics.DrawMeshInstancedIndirect(instanceMesh, submeshIndex, drawMat, bound, argsBuffer);
		}
		else
		{
			Debug.LogError("未设置instance相关属性，无法绘制");
		}
	}

	public void drawParticleInstance(Mesh meshInstance, int submesh, Material mat, Bounds bound)
	{
		setInstance(meshInstance, submesh, mat);
		drawParticleInstance(bound);
	}

	public void setInstance(Mesh meshInstance, int submesh, Material mat)
	{
		instanceMesh = meshInstance;
		submeshIndex = submesh;
		initializeArgsBuffer();
		drawMat = mat;
	}

	public void release()
	{
		cmd?.Release();
		particleBuffer?.Release();
		particleBuffer2?.Release();
		argsBuffer?.Release();
		systemBuffer?.Release();
		sortDataBuffer?.Release();
		clipBuffer?.Release();
		customDataBuffer?.Release();
		customDataBuffer2?.Release();
		customDrawBuffer?.Release();
		drawBuffer?.Release();
	}

	private void sortingParticle()
	{
		cmd.SetComputeBufferParam(particleCS, particleSortingKernelIndex, "_sortingBuffer", bufferStack.aliveBuffer);
		cmd.SetComputeBufferParam(particleCS, particleSortingKernelIndex2, "_sortingBuffer", bufferStack.aliveBuffer);
		cmd.SetComputeBufferParam(particleCS, particleSortingKernelIndex, "_systemBuffer", systemBuffer);
		cmd.SetComputeBufferParam(particleCS, particleSortingKernelIndex2, "_systemBuffer", systemBuffer);
		cmd.SetComputeBufferParam(particleCS, particleSortingKernelIndex, "_sortingDataBuffer", sortDataBuffer);
		cmd.SetComputeBufferParam(particleCS, particleSortingKernelIndex2, "_sortingDataBuffer", sortDataBuffer);
		cmd.DispatchCompute(particleCS, particleSortingKernelIndex, Mathf.CeilToInt((float)MaxParticleCount / 2f / 256f), 1, 1);
		int num = 1024;
		if (MaxParticleCount > 512)
		{
			cmd.SetComputeIntParam(particleCS, "_sortingWidth", num);
			cmd.SetComputeIntParam(particleCS, "_way", 4);
			cmd.DispatchCompute(particleCS, particleSortingKernelIndex2, Mathf.CeilToInt((float)MaxParticleCount / 2f / 512f), 1, 1);
		}
		num *= 2;
		while (num / 2 < MaxParticleCount)
		{
			int num2 = num;
			cmd.SetComputeIntParam(particleCS, "_sortingWidth", num2);
			cmd.SetComputeIntParam(particleCS, "_way", 1);
			cmd.DispatchCompute(particleCS, particleSortingKernelIndex2, Mathf.CeilToInt((float)MaxParticleCount / 2f / 512f), 1, 1);
			for (num2 /= 2; num2 > 512; num2 /= 2)
			{
				cmd.SetComputeIntParam(particleCS, "_sortingWidth", num2);
				cmd.SetComputeIntParam(particleCS, "_way", 2);
				cmd.DispatchCompute(particleCS, particleSortingKernelIndex2, Mathf.CeilToInt((float)MaxParticleCount / 2f / 512f), 1, 1);
			}
			cmd.SetComputeIntParam(particleCS, "_sortingWidth", num2);
			cmd.SetComputeIntParam(particleCS, "_way", 3);
			cmd.DispatchCompute(particleCS, particleSortingKernelIndex2, Mathf.CeilToInt((float)MaxParticleCount / 2f / 512f), 1, 1);
			num *= 2;
		}
	}

	private void copyBuffer()
	{
		cmd.SetComputeBufferParam(particleCS, particleCopyBufferKernel, "_sortingBuffer", bufferStack.aliveBuffer);
		cmd.SetComputeBufferParam(particleCS, particleCopyBufferKernel, "_sortingDataBuffer", sortDataBuffer);
		cmd.SetComputeBufferParam(particleCS, particleCopyBufferKernel, "_bufferToDraw", drawBuffer);
		cmd.SetComputeBufferParam(particleCS, particleCopyBufferKernel, "_clipData", clipBuffer);
		cmd.SetComputeBufferParam(particleCS, particleCopyBufferKernel, "_customBuffer", customStack.aliveBuffer);
		cmd.SetComputeBufferParam(particleCS, particleCopyBufferKernel, "_customToDraw", customBufferToDraw);
		if (needClip && needSort)
		{
			cmd.CopyCounterValue(clipBuffer, systemBuffer, 0u);
		}
		cmd.SetComputeBufferParam(particleCS, particleCopyBufferKernel, "_systemBuffer", systemBuffer);
		cmd.DispatchCompute(particleCS, particleCopyBufferKernel, Mathf.CeilToInt((float)MaxParticleCount / 64f), 1, 1);
	}

	private void particleClip()
	{
		GeometryUtility.CalculateFrustumPlanes(clipCamera, cameraPlanes);
		for (int i = 0; i < cameraPlanes.Length; i++)
		{
			Vector3 normal = cameraPlanes[i].normal;
			cmd.SetComputeVectorParam(particleCS, planeTagList[i], new Vector4(normal.x, normal.y, normal.z, cameraPlanes[i].distance));
		}
		if (isWorldParticle)
		{
			cmd.SetComputeMatrixParam(particleCS, "_O2WMatrix", parentTransform.localToWorldMatrix);
		}
		cmd.SetBufferCounterValue(clipBuffer, 0u);
		cmd.SetComputeBufferParam(particleCS, particleClipKernel, "_systemBuffer", systemBuffer);
		cmd.SetComputeBufferParam(particleCS, particleClipKernel, "_clipDataUpadte", clipBuffer);
		cmd.SetComputeBufferParam(particleCS, particleClipKernel, "_sortingBuffer", bufferStack.aliveBuffer);
		cmd.SetComputeIntParam(particleCS, "_needClip", 1);
		cmd.DispatchCompute(particleCS, particleClipKernel, Mathf.CeilToInt((float)MaxParticleCount / 64f), 1, 1);
		if (!needSort)
		{
			cmd.CopyCounterValue(clipBuffer, systemBuffer, 0u);
		}
	}

	public ComputeShader getSpawShader()
	{
		return spawCS;
	}

	public ComputeShader getSimulateShader()
	{
		return simulateCS;
	}
}
