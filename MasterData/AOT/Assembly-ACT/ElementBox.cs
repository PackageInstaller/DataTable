using CSParticleSystem;
using UnityEngine;
using UnityEngine.Serialization;

[ExecuteAlways]
public class ElementBox : MonoBehaviour
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

	private struct SimBuffer
	{
		public Vector3 gravity;

		public Vector3 startSpeed;

		public float dirRandom;

		public Vector4 boundUp;

		public Vector4 boundForward;

		public Vector4 boundRight;

		public Vector3 boundCenter;

		public Vector3 windDirection;

		public float noiseScale;

		public float noiseIntensity;

		public float airDrag;

		public float updateSpeed;
	}

	public bool MaterialCheckMode;

	public bool NeedSorting;

	public bool NeedClip;

	public int MaxParticalCount = 1000;

	private int particalCountCatch;

	private int perParticalPointCatch;

	[Tooltip("每帧发射的粒子数量")]
	public float spawPreSecond = 10f;

	[Tooltip("旋转随机性")]
	[Range(0f, 1f)]
	public float rotateRandom;

	[Tooltip("方向随机性")]
	[Range(0f, 1f)]
	public float DirectRandom;

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

	[Tooltip("重力")]
	public Vector3 gravity = new Vector3(0f, -9.8f, 0f);

	[Tooltip("风力")]
	public Vector3 wind = new Vector3(0f, 0f, 0f);

	[Tooltip("起始速度")]
	public Vector3 StartVelocity = new Vector3(0f, 0f, 0f);

	[Tooltip("阻力")]
	public float airDrag;

	[Tooltip("噪声大小")]
	public float noiseScale;

	[Tooltip("噪声强度")]
	public float noiseIntensity;

	[Tooltip("演算速度")]
	[Range(0f, 3f)]
	public float updateSpeed = 1f;

	public ComputeShader BaseCS;

	public ComputeShader ElementCS;

	private ComputeShader m_spawnCS;

	private ComputeShader m_updateCS;

	private ComputeShader m_BaseCS;

	private int particalKernelIndex;

	private int pointUpdateKernelIndex;

	private int lineCreatIndex;

	public Mesh instanceMesh;

	public Material instanceMat;

	private Material m_InstanceMat;

	public Camera ClipCamera;

	private Mesh cubeMesh;

	private BoxCollider boxCollider;

	private ComputeBuffer ExtraSimBufferData;

	private CSParticle.ExtraBufferData ExtraSimBuffer;

	private SimBuffer[] ExtraSimData;

	private Bounds bounds;

	private CSParticle _csPartical;

	private bool _initialized;

	private Plane[] planes = new Plane[6];

	private void RefreshBuffer()
	{
		ExtraSimData[0].startSpeed = Vector3.zero;
		ExtraSimData[0].boundCenter = transform.position;
		Matrix4x4 localToWorldMatrix = transform.localToWorldMatrix;
		Vector4 vector = localToWorldMatrix * new Vector4(0f, 1f, 0f, 0f);
		Vector4 normalized = vector.normalized;
		ExtraSimData[0].boundUp = new Vector4(normalized.x, normalized.y, normalized.z, vector.magnitude / 2f);
		Vector4 vector2 = localToWorldMatrix * new Vector4(0f, 0f, 1f, 0f);
		normalized = vector2.normalized;
		ExtraSimData[0].boundForward = new Vector4(normalized.x, normalized.y, normalized.z, vector2.magnitude / 2f);
		Vector4 vector3 = localToWorldMatrix * new Vector4(1f, 0f, 0f, 0f);
		normalized = vector3.normalized;
		ExtraSimData[0].boundRight = new Vector4(normalized.x, normalized.y, normalized.z, vector3.magnitude / 2f);
		ExtraSimData[0].gravity = gravity;
		ExtraSimData[0].windDirection = wind;
		ExtraSimData[0].noiseIntensity = noiseIntensity;
		ExtraSimData[0].noiseScale = noiseScale;
		ExtraSimData[0].airDrag = airDrag;
		ExtraSimData[0].startSpeed = StartVelocity;
		ExtraSimData[0].dirRandom = DirectRandom;
		ExtraSimData[0].updateSpeed = updateSpeed;
		ExtraSimBufferData.SetData(ExtraSimData);
	}

	private void OnEnable()
	{
		_initialized = false;
		boxCollider = GetComponent<BoxCollider>();
		if (boxCollider == null)
		{
			boxCollider = gameObject.AddComponent<BoxCollider>();
			boxCollider.center = Vector3.zero;
			boxCollider.size = Vector3.one;
		}
		MeshFilter component = GetComponent<MeshFilter>();
		cubeMesh = ((component != null) ? component.sharedMesh : null);
		m_spawnCS = Object.Instantiate(ElementCS);
		m_updateCS = Object.Instantiate(ElementCS);
		m_BaseCS = Object.Instantiate(BaseCS);
		ExtraSimData = new SimBuffer[1];
		ExtraSimData[0] = default;
		ExtraSimBufferData = new ComputeBuffer(1, 116);
		ExtraSimBuffer = new CSParticle.ExtraBufferData("_ElementBoxBuffer", ExtraSimBufferData);
		CSParticle.IntData intData = new CSParticle.IntData(NeedSorting, NeedClip, ClipCamera, m_worldParticle: true);
		_csPartical = new CSParticle(MaxParticalCount, spawPreSecond, m_BaseCS, m_updateCS, m_spawnCS, transform, intData, ExtraSimBuffer);
		m_InstanceMat = new Material(instanceMat);
		setParticalParm();
		_initialized = true;
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
		if (_csPartical != null)
		{
			setParticalParm();
			_csPartical.refreshMaxParticleCount(MaxParticalCount);
		}
	}

	private bool checkInScreen(Camera cameraInput, Bounds bounds)
	{
		if (cameraInput == null)
		{
			return false;
		}
		GeometryUtility.CalculateFrustumPlanes(cameraInput, planes);
		return GeometryUtility.TestPlanesAABB(planes, bounds);
	}

	private bool CameraCheck()
	{
		if (boxCollider == null)
		{
			return false;
		}
		Bounds bounds = boxCollider.bounds;
		Camera[] allCameras = Camera.allCameras;
		foreach (Camera cameraInput in allCameras)
		{
			if (checkInScreen(cameraInput, bounds))
			{
				return true;
			}
		}
		return false;
	}

	private void Update()
	{
		if (!_initialized || _csPartical == null || !CameraCheck() || _csPartical == null)
		{
			return;
		}
		_csPartical.setSpawPreSecond(spawPreSecond * updateSpeed);
		_csPartical.updateParticle();
		if ((bool)instanceMesh && (bool)instanceMat)
		{
			if (MaterialCheckMode)
			{
				instanceMat.SetMatrix("_O2W_I_Matrix", transform.worldToLocalMatrix);
				instanceMat.SetMatrix("_O2W_Matrix", transform.localToWorldMatrix);
				_csPartical.drawParticleInstance(instanceMesh, 0, instanceMat, boxCollider.bounds);
			}
			else
			{
				m_InstanceMat.SetMatrix("_O2W_I_Matrix", transform.worldToLocalMatrix);
				m_InstanceMat.SetMatrix("_O2W_Matrix", transform.localToWorldMatrix);
				_csPartical.drawParticleInstance(instanceMesh, 0, m_InstanceMat, boxCollider.bounds);
			}
		}
		RefreshBuffer();
	}

	private void OnDrawGizmosSelected()
	{
		if (!(cubeMesh == null))
		{
			Gizmos.color = new Color(0.2f, 0.7f, 0.9f, 0.5f);
			Gizmos.DrawMesh(cubeMesh, transform.position, transform.rotation, transform.lossyScale);
		}
	}

	private void OnDisable()
	{
		_initialized = false;
		_csPartical?.release();
		_csPartical = null;
	}
}
