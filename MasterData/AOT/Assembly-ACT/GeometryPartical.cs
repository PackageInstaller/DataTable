using CSParticleSystem;
using UnityEngine;
using UnityEngine.Serialization;

[ExecuteAlways]
public class GeometryPartical : MonoBehaviour
{
	private struct ParticalData
	{
		public Vector3 position;

		public Vector3 rotation;

		public float scale;

		public Vector3 velocity;

		public float lifeTime;

		public float age;

		public int dead;

		public int pointCount;
	}

	private struct LineInstanceData
	{
		public Matrix4x4 transform;
	}

	private struct PointPositionData
	{
		public Vector3 position;
	}

	private struct LineData
	{
		public int frontIndex;

		public int lastIndex;
	}

	public bool NeedSorting;

	public bool NeedClip;

	public int MaxParticalCount = 1000;

	public int MaxPointPrePartical = 4;

	private int particalCountCatch;

	private int perParticalPointCatch;

	[Tooltip("每帧发射的粒子数量")]
	public float spawPreSecond = 10f;

	[Tooltip("旋转随机性")]
	[Range(0f, 1f)]
	public float rotateRandom;

	[FormerlySerializedAs("speedRandom")]
	[Tooltip("速度随机性")]
	[Range(0f, 1f)]
	public float velocityRandom;

	[Tooltip("大小随机性")]
	[Range(0f, 1f)]
	public float sizeRandom;

	[Tooltip("生命周期随机性")]
	[Range(0f, 1f)]
	public float lifeTimeRandom;

	[Tooltip("整体大小")]
	[Range(0f, 10f)]
	public float particalSize;

	[Tooltip("速度大小")]
	[Range(0f, 10f)]
	public float particalSpeed;

	[Tooltip("旋转速度")]
	[Range(0f, 10f)]
	public float particalRotateSpeed;

	[Tooltip("生命周期")]
	public float particalLifeTime;

	public ComputeShader particalCS;

	public ComputeShader updateShader;

	private int particalKernelIndex;

	private int pointUpdateKernelIndex;

	private int lineCreatIndex;

	private ComputeBuffer pointPositionBuffer;

	private ComputeBuffer linePointIndexBuffer;

	private ComputeBuffer lineInstanceBuffer;

	private PointPositionData[] pointPosData;

	private LineData[] lineIndexData;

	private LineInstanceData[] lineIntanceData;

	public Mesh instanceMesh;

	public Material instanceMat;

	private Material m_mat;

	private CSParticle _csPartical;

	private void OnEnable()
	{
		ComputeShader computeShader = Object.Instantiate(particalCS);
		ComputeShader simulateParticleCS = Object.Instantiate(updateShader);
		CSParticle.IntData intData = new CSParticle.IntData(NeedSorting, NeedClip, null, m_worldParticle: false);
		_csPartical = new CSParticle(MaxParticalCount, spawPreSecond, computeShader, simulateParticleCS, computeShader, transform, intData);
		setParticalParm();
	}

	private void setParticalParm()
	{
		if (_csPartical != null)
		{
			_csPartical.setRotateRandom(rotateRandom);
			_csPartical.setSizeRandom(sizeRandom);
			_csPartical.setSpeedRandom(velocityRandom);
			_csPartical.setLifeTimeRandom(lifeTimeRandom);
			_csPartical.setBaseSize(particalSize);
			_csPartical.setBaseSpeed(particalSpeed);
			_csPartical.setBaseLifeTime(particalLifeTime);
			_csPartical.setBaseRotationSpeed(particalRotateSpeed);
			_csPartical.setSpawPreSecond(spawPreSecond);
			_csPartical.refreshMaxParticleCount(MaxParticalCount);
		}
	}

	private void OnValidate()
	{
		setParticalParm();
		_csPartical.refreshMaxParticleCount(MaxParticalCount);
	}

	private void Update()
	{
		if (_csPartical != null)
		{
			_csPartical.updateParticle();
			if ((bool)instanceMesh && (bool)instanceMat)
			{
				Bounds bound = new Bounds(transform.position, new Vector3(2000f, 2000f, 2000f));
				instanceMat.SetMatrix("_O2W_I_Matrix", transform.worldToLocalMatrix);
				instanceMat.SetMatrix("_O2W_Matrix", transform.localToWorldMatrix);
				_csPartical.drawParticleInstance(instanceMesh, 0, instanceMat, bound);
			}
		}
	}

	private void rebuildBuffer()
	{
		releaseBuffer();
		pointPositionBuffer = new ComputeBuffer(MaxParticalCount * MaxPointPrePartical, 12);
		lineInstanceBuffer = new ComputeBuffer(MaxParticalCount * (MaxPointPrePartical - 1), 64);
		linePointIndexBuffer = new ComputeBuffer(MaxParticalCount * (MaxPointPrePartical - 1), 8);
		particalKernelIndex = particalCS.FindKernel("");
		pointUpdateKernelIndex = particalCS.FindKernel("");
		lineCreatIndex = particalCS.FindKernel("");
		particalCS.SetBuffer(pointUpdateKernelIndex, "_pointPos", pointPositionBuffer);
		particalCS.SetBuffer(lineCreatIndex, "_lineData", lineInstanceBuffer);
		particalCS.SetBuffer(lineCreatIndex, "_pointPos", pointPositionBuffer);
		particalCS.SetBuffer(lineCreatIndex, "_linePoint", linePointIndexBuffer);
		lineIntanceData = new LineInstanceData[MaxParticalCount * (MaxPointPrePartical - 1)];
		lineIndexData = new LineData[MaxParticalCount * (MaxPointPrePartical - 1)];
		int num = MaxPointPrePartical - 1;
		for (int i = 0; i < MaxParticalCount; i++)
		{
			int num2 = i * num;
			int num3 = i * MaxPointPrePartical;
			for (int j = 0; j < num; j++)
			{
				lineIndexData[num2 + j].frontIndex = num3;
				num3++;
				lineIndexData[num2 + j].lastIndex = num3;
				lineIntanceData[num2 + j].transform = Matrix4x4.zero;
			}
		}
		lineInstanceBuffer.SetData(lineIntanceData);
		linePointIndexBuffer.SetData(lineIndexData);
		pointPosData = new PointPositionData[MaxParticalCount * MaxPointPrePartical];
		for (int k = 0; k < MaxParticalCount; k++)
		{
			int num4 = k * MaxPointPrePartical;
			for (int l = 0; l < MaxPointPrePartical; l++)
			{
				pointPosData[num4 + l].position = Random.insideUnitSphere;
			}
		}
		pointPositionBuffer.SetData(pointPosData);
	}

	private void creatInstanceMesh()
	{
		if (!instanceMesh)
		{
			Vector3[] vertices = new Vector3[4]
			{
				new Vector3(0f, 0f, 0f),
				new Vector3(0f, 1f, 0f),
				new Vector3(1f, 1f, 0f),
				new Vector3(1f, 0f, 0f)
			};
			Vector2[] uv = new Vector2[4]
			{
				new Vector2(0f, 0f),
				new Vector2(0f, 1f),
				new Vector2(1f, 1f),
				new Vector2(1f, 0f)
			};
			int[] triangles = new int[6] { 0, 1, 2, 0, 2, 3 };
			instanceMesh = new Mesh();
			instanceMesh.vertices = vertices;
			instanceMesh.uv = uv;
			instanceMesh.triangles = triangles;
		}
	}

	private bool checkCatch()
	{
		if (particalCountCatch == MaxParticalCount)
		{
			return perParticalPointCatch == MaxPointPrePartical;
		}
		return false;
	}

	private void refreshCatch()
	{
		particalCountCatch = MaxParticalCount;
		perParticalPointCatch = MaxPointPrePartical;
	}

	private void releaseBuffer()
	{
		pointPositionBuffer.Release();
		lineInstanceBuffer.Release();
		linePointIndexBuffer.Release();
	}

	private void OnDisable()
	{
		_csPartical.release();
		_csPartical = null;
	}
}
