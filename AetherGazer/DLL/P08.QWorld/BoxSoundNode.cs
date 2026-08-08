using UnityEngine;

public class BoxSoundNode : BaseSoundNode
{
	[SerializeField]
	private CriAtomSource src;

	[Header("立方体音效范围（范围内：pan5.1 范围外：3D）")]
	[SerializeField]
	private Vector3 halfAreaLength = new Vector3(5f, 4f, 3f);

	[SerializeField]
	private float dis;

	[Header("音效辅助范围框")]
	[SerializeField]
	private float outRadius;

	[SerializeField]
	private bool showArea;

	[Header("内嵌范围框（根据次范围调整Aisac属性）")]
	[SerializeField]
	private bool boxEmbedding;

	[SerializeField]
	private Vector3 embeddingHalfLength = new Vector3(5f, 4f, 3f);

	[SerializeField]
	private float embeddingRadius;

	[SerializeField]
	private Transform embeddingTrs;

	[SerializeField]
	private float embeddingDis;

	[SerializeField]
	private string embeddingCtrlName = "";

	[SerializeField]
	private AnimationCurve embeddingCurve;

	private float preEbDis;

	private Transform soundTrs;

	private Transform areaTrs;

	private Transform roleTrs;

	protected override void NodeStart()
	{
		dis = 0f;
		embeddingDis = 0f;
		preEbDis = 0f;
		soundTrs = src.transform;
		areaTrs = base.transform;
		roleTrs = QWorldCameraManager.Instance.MainCamera.transform;
		intervalTick = 10;
		tickCount = 0;
		src.Play();
	}

	protected override void NodeProcess(bool forceInit = false)
	{
		preEbDis = embeddingDis;
		Vector3 vector = DisFunc(roleTrs.position);
		intervalTick = Mathf.Min(10 + Mathf.FloorToInt(dis / 10f), 30);
		bool flag = false;
		if ((soundTrs.localPosition != vector) | forceInit)
		{
			soundTrs.localPosition = vector;
			if (dis > 0f)
			{
				src.player.SetPanType(CriAtomEx.PanType.Pos3d);
			}
			else
			{
				src.player.SetPanType(CriAtomEx.PanType.Pan3d);
			}
			flag = true;
		}
		if (((preEbDis != embeddingDis) | forceInit) && !string.IsNullOrEmpty(embeddingCtrlName))
		{
			flag = true;
			src.player.SetAisacControl(embeddingCtrlName, embeddingCurve.Evaluate(embeddingDis));
		}
		if (flag)
		{
			src.player.UpdateAll();
		}
	}

	private Vector3 DisFunc(Vector3 point)
	{
		embeddingDis = 0f;
		if (boxEmbedding)
		{
			Vector3 vector = embeddingTrs.InverseTransformPoint(point);
			float num = Mathf.Max(Mathf.Abs(vector.x) - embeddingHalfLength.x, 0f);
			float num2 = Mathf.Max(Mathf.Abs(vector.y) - embeddingHalfLength.y, 0f);
			float num3 = Mathf.Max(Mathf.Abs(vector.z) - embeddingHalfLength.z, 0f);
			if (num + num2 + num3 > 0f)
			{
				embeddingDis = Mathf.Sqrt(num * num + num2 * num2 + num3 * num3);
			}
		}
		else
		{
			embeddingDis = Mathf.Max(Vector3.Distance(embeddingTrs.position, point) - embeddingRadius, 0f);
		}
		Vector3 zero = Vector3.zero;
		dis = 0f;
		Vector3 vector2 = areaTrs.InverseTransformPoint(point);
		float num4 = Mathf.Max(Mathf.Abs(vector2.x) - halfAreaLength.x, 0f);
		float num5 = Mathf.Max(Mathf.Abs(vector2.y) - halfAreaLength.y, 0f);
		float num6 = Mathf.Max(Mathf.Abs(vector2.z) - halfAreaLength.z, 0f);
		if (num4 + num5 + num6 > 0f)
		{
			dis = Mathf.Sqrt(num4 * num4 + num5 * num5 + num6 * num6);
			zero.x = Mathf.Clamp(vector2.x, 0f - halfAreaLength.x, halfAreaLength.x);
			zero.y = Mathf.Clamp(vector2.y, 0f - halfAreaLength.y, halfAreaLength.y);
			zero.z = Mathf.Clamp(vector2.z, 0f - halfAreaLength.z, halfAreaLength.z);
		}
		return zero;
	}

	private void OnDrawGizmos()
	{
		if (!(areaTrs == null) && !(embeddingTrs == null) && !(soundTrs == null))
		{
			Gizmos.matrix = Matrix4x4.TRS(areaTrs.position, areaTrs.rotation, Vector3.one);
			Gizmos.color = new Color(0f, 1f, 0f, 0.3f);
			Gizmos.DrawCube(Vector3.zero, halfAreaLength * 2f);
			if (boxEmbedding)
			{
				Gizmos.matrix = Matrix4x4.TRS(embeddingTrs.position, embeddingTrs.rotation, Vector3.one);
				Gizmos.color = new Color(0f, 1f, 1f, 0.6f);
				Gizmos.DrawCube(Vector3.zero, embeddingHalfLength * 2f);
			}
			else
			{
				Gizmos.matrix = Matrix4x4.TRS(embeddingTrs.position, Quaternion.identity, Vector3.one);
				Gizmos.color = new Color(0f, 1f, 1f, 0.6f);
				Gizmos.DrawSphere(Vector3.zero, embeddingRadius);
			}
			if (showArea)
			{
				Gizmos.matrix = Matrix4x4.TRS(soundTrs.position, Quaternion.identity, Vector3.one);
				Gizmos.color = new Color(1f, 1f, 0f, 0.3f);
				Gizmos.DrawSphere(Vector3.zero, outRadius);
			}
		}
	}
}
