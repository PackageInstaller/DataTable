using System;
using System.Text.RegularExpressions;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
public class DLCExpressionBehaviour : PlayableBehaviour
{
	[NonSerialized]
	public ExpressionPartEnum m_expressionPart;

	[SnapTo(precision = 1f)]
	[Min(0f)]
	public float m_expressionID;

	[NonSerialized]
	public bool m_isClone;

	[NonSerialized]
	public bool m_enableSkinMeshRenderer;

	[NonSerialized]
	public bool m_resetEnableSkinMeshRenderer;

	private GameObject m_gameObject;

	public ExposedReference<Transform> prefabRoot;

	[NonSerialized]
	public GameObject m_owner;

	[NonSerialized]
	public Transform m_checkTPoseRoot;

	[NonSerialized]
	public FaceEffectControl m_effectControl;

	[NonSerialized]
	public SkinnedMeshRenderer m_skinnedMeshRenderer;

	[NonSerialized]
	public bool m_isFindTpose;

	[Tooltip("0=关闭，100=打开")]
	[Range(0f, 100f)]
	public float m_blendShapeOpenValue;

	[Tooltip("0-100放大")]
	[Range(0f, 100f)]
	public float m_blendShapeBigValue;

	[Tooltip("0-100缩小")]
	[Range(0f, 100f)]
	public float m_blendShapeSmallnValue;

	[Tooltip("0-100向上移动")]
	[Range(0f, 100f)]
	public float m_blendShapeUpValue;

	[Tooltip("0-100向下移动")]
	[Range(0f, 100f)]
	public float m_blendShapeDownValue;

	[Tooltip("0-100向左移动")]
	[Range(0f, 100f)]
	public float m_blendShapeLeftValue;

	[Tooltip("0-100向右移动")]
	[Range(0f, 100f)]
	public float m_blendShapeRightValue;

	public Color color = Color.white;

	public float rotationAngle;

	public Vector4 scale = new Vector4(1f, 1f, 0f, 0f);

	public Vector4 jitter;

	public Vector4 noise;

	public bool flipX;

	private Transform root;

	private int ExpressionID => Mathf.FloorToInt(Mathf.Max(0f, m_expressionID));

	public void PrepareComponent(Transform root)
	{
		if (!(root != null))
		{
			return;
		}
		string expressionPath = GetExpressionPath(root, m_expressionPart);
		GameObject gameObject = root.Find(expressionPath)?.gameObject;
		if (gameObject != null)
		{
			if (m_isClone)
			{
				m_gameObject = UnityEngine.Object.Instantiate(gameObject, gameObject.transform.parent);
			}
			else
			{
				m_gameObject = gameObject;
			}
			m_effectControl = U3DUtil.Get<FaceEffectControl>(m_gameObject);
			m_skinnedMeshRenderer = U3DUtil.Get<SkinnedMeshRenderer>(m_gameObject);
		}
	}

	private void DestroyComponent()
	{
		if (m_isClone && (bool)m_gameObject)
		{
			if (Application.isPlaying)
			{
				UnityEngine.Object.Destroy(m_gameObject);
			}
			else
			{
				UnityEngine.Object.DestroyImmediate(m_gameObject);
			}
		}
		m_gameObject = null;
		m_skinnedMeshRenderer = null;
		m_effectControl = null;
	}

	public void UpdatePart(ExpressionPartEnum part, bool isClone, Transform root)
	{
		if (part != m_expressionPart || isClone != m_isClone || root != this.root)
		{
			DestroyComponent();
			m_expressionPart = part;
			m_isClone = isClone;
			this.root = root;
			PrepareComponent(this.root);
		}
	}

	public void UpdatePart(ExpressionPartEnum part, bool isClone)
	{
		UpdatePart(part, isClone, root);
	}

	public void UpdatePart(Transform root)
	{
		UpdatePart(m_expressionPart, m_isClone, root);
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (m_gameObject != null)
		{
			if (m_isClone)
			{
				m_gameObject?.SetActive(value: true);
			}
			if (!m_effectControl.isValidSheetId(ExpressionID))
			{
				Debug.LogError($"DLC表情节点 {m_expressionID} 超过最大值");
			}
			m_skinnedMeshRenderer.enabled = m_enableSkinMeshRenderer;
		}
		if (m_isFindTpose)
		{
			m_checkTPoseRoot = FindValidTPoseRoot(m_owner.transform.parent);
		}
		else
		{
			m_checkTPoseRoot = m_owner.transform.parent;
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		base.ProcessFrame(playable, info, playerData);
		Transform transform = FindValidCharaTPoseRoot(m_checkTPoseRoot);
		UpdatePart(transform);
		UpdateFaceControlEffect();
		UpdateBlendShapeParams();
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (m_gameObject != null)
		{
			m_skinnedMeshRenderer.enabled = m_resetEnableSkinMeshRenderer;
			if (m_isClone)
			{
				m_gameObject?.SetActive(value: false);
			}
		}
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		DestroyComponent();
	}

	private string GetExpressionPath(Transform root, ExpressionPartEnum expressionPart)
	{
		string text = string.Empty;
		switch (expressionPart)
		{
		case ExpressionPartEnum.LEFT_FOREHEAD:
			text = "face_S_F_L";
			break;
		case ExpressionPartEnum.RIGHT_FOREHEAD:
			text = "face_S_F_R";
			break;
		case ExpressionPartEnum.LEFT_EYE:
			text = "face_S_E_L";
			break;
		case ExpressionPartEnum.RIGHT_EYE:
			text = "face_S_E_R";
			break;
		case ExpressionPartEnum.LEFT_CHEEK:
			text = "face_S_C_L";
			break;
		case ExpressionPartEnum.RIGHT_CHEEK:
			text = "face_S_C_R";
			break;
		case ExpressionPartEnum.MOUTH:
			text = "face_S_M";
			break;
		}
		string pattern = "^\\d+";
		Match match = Regex.Match(root.name, pattern);
		if (match.Success)
		{
			return $"{match}ui/{match}ui_tpose/" + text;
		}
		Debug.LogError($"{m_owner} 无法分析出对应的角色 ID");
		return text;
	}

	private Transform FindDeepChild(Transform parent, string name, int deepCount)
	{
		if (deepCount <= 0)
		{
			return null;
		}
		foreach (Transform item in parent)
		{
			if (item.name == name)
			{
				return item;
			}
			Transform transform2 = FindDeepChild(item, name, deepCount - 1);
			if (transform2 != null)
			{
				return transform2;
			}
		}
		return null;
	}

	private Transform FindValidTPoseRoot(Transform root)
	{
		if ((bool)root)
		{
			if (root == this.root)
			{
				return root;
			}
			string pattern = "^\\d+";
			Match match = Regex.Match(root.name, pattern);
			if (match.Success)
			{
				Transform transform = FindDeepChild(root, $"{match}ui_tpose", 5);
				if ((bool)transform)
				{
					return transform.parent.parent;
				}
			}
		}
		return null;
	}

	private Transform FindValidCharaTPoseRoot(Transform root)
	{
		return root;
	}

	private void UpdateFaceControlEffect()
	{
		m_effectControl.SheetId = ExpressionID;
		m_effectControl.Color = color;
		m_effectControl.RotationAngle = rotationAngle;
		m_effectControl.ScaleParam = scale;
		m_effectControl.JitterParam = jitter;
		m_effectControl.NoiseParam = noise;
		m_effectControl.FlipX = flipX;
	}

	private void UpdateBlendShapeParams()
	{
		m_skinnedMeshRenderer.SetBlendShapeWeight(0, m_blendShapeOpenValue);
		m_skinnedMeshRenderer.SetBlendShapeWeight(1, m_blendShapeBigValue);
		m_skinnedMeshRenderer.SetBlendShapeWeight(2, m_blendShapeSmallnValue);
		m_skinnedMeshRenderer.SetBlendShapeWeight(3, m_blendShapeUpValue);
		m_skinnedMeshRenderer.SetBlendShapeWeight(4, m_blendShapeDownValue);
		m_skinnedMeshRenderer.SetBlendShapeWeight(5, m_blendShapeLeftValue);
		m_skinnedMeshRenderer.SetBlendShapeWeight(6, m_blendShapeRightValue);
	}
}
