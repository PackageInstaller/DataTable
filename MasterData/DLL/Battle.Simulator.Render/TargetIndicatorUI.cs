using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.UI;

public class TargetIndicatorUI : MonoBehaviour
{
	private bool mUnderPathControl = true;

	public Image mTargetIcon;

	public Text mDistanceText;

	public float mHeight = 2f;

	public float mEllipseHeight = 266f;

	public Vector2 mIndicatorSize = new Vector2(30f, 40f);

	private RectTransform mTran;

	private RectTransform mCanvasTran;

	private Vector3 sNextPostion;

	private Vector3 sCurrPostion;

	private float sDistance;

	private bool sEnable;

	private float criticalDis;

	private float elasticHeight;

	private float mMagicFloat = 1.5f;

	private int mCurrentDistance;

	private Camera mUICamera;

	public bool MUnderPathControl
	{
		get
		{
			return mUnderPathControl;
		}
		set
		{
			mUnderPathControl = value;
		}
	}

	public void DrawUI(bool enable, Vector3 curentPosition, Vector3 positon, float distance)
	{
		sCurrPostion = curentPosition;
		sNextPostion = positon;
		sDistance = distance;
		sEnable = enable;
		if (base.gameObject.activeInHierarchy != sEnable)
		{
			base.gameObject.SetActive(sEnable);
		}
	}

	private void DrawText(bool enable)
	{
		if (!enable)
		{
			mDistanceText.text = "";
			return;
		}
		int num = (int)(sDistance / mMagicFloat);
		if (num != mCurrentDistance || string.IsNullOrEmpty(mDistanceText.text))
		{
			mCurrentDistance = num;
			string empty = string.Empty;
			empty = ((mCurrentDistance < CommonString.Numbers.Length && mCurrentDistance >= 0) ? CommonString.Numbers[mCurrentDistance] : mCurrentDistance.ToString());
			mDistanceText.text = empty;
		}
	}

	private void Start()
	{
		mTran = GetComponent<RectTransform>();
		mCanvasTran = mTran.parent.gameObject.GetComponent<RectTransform>();
		base.gameObject.SetActive(sEnable);
	}

	private void Update()
	{
		if (!sEnable)
		{
			if (base.gameObject.activeInHierarchy)
			{
				base.gameObject.SetActive(value: false);
			}
			return;
		}
		if (!base.gameObject.activeInHierarchy)
		{
			base.gameObject.SetActive(value: true);
		}
		if (mUICamera == null)
		{
			mUICamera = CanvasManager.Instance.uiCamera;
		}
		Vector2 vector = CalcScreenEllipsePoint();
		mTran.localPosition = vector;
	}

	private Vector2 CalcScreenEllipsePoint()
	{
		Vector2 zero = Vector2.zero;
		sCurrPostion = Camera.main.transform.position + Camera.main.transform.forward;
		Vector3 vector = sNextPostion + new Vector3(0f, mHeight, 0f);
		Vector3 vector2 = vector - sCurrPostion;
		float num = mEllipseHeight;
		float num2 = num * (float)Screen.width / (float)Screen.height;
		float num3 = num;
		Vector3 vector3 = sCurrPostion;
		Vector2 vector4 = Camera.main.WorldToScreenPoint(vector3);
		Vector3 position = vector;
		Vector3 vector5 = Camera.main.WorldToScreenPoint(position);
		vector5.x -= vector4.x;
		vector5.y -= vector4.y;
		Vector2 sizeDelta = (CanvasManager.Instance.GetUIResolution(0).transform as RectTransform).sizeDelta;
		vector5.x *= sizeDelta.x / (float)Screen.width;
		vector5.y *= sizeDelta.y / (float)Screen.height;
		if (vector5.x * vector5.x / (num2 * num2) + vector5.y * vector5.y / (num3 * num3) < 1f && vector5.z >= 0f)
		{
			zero = vector5;
			DrawText(enable: true);
		}
		else
		{
			DrawText(enable: false);
			position = vector3 + vector2.normalized;
			vector5 = Camera.main.WorldToScreenPoint(position);
			Vector2 vector6 = (Vector2)vector5 - vector4;
			float num4 = vector6.y / vector6.x;
			float num5 = Mathf.Sign(vector6.x) * Mathf.Sqrt(1f / (1f / (num2 * num2) + num4 * num4 / (num3 * num3)));
			float y = Mathf.Sign(vector6.y) * num3 * Mathf.Sqrt(1f - num5 * num5 / (num2 * num2));
			zero = new Vector2(num5, y);
		}
		return zero;
	}

	private Vector2 CalcScreenRectPoint()
	{
		Vector3 position = sNextPostion + new Vector3(0f, mHeight, 0f);
		Vector3 vector = Camera.main.WorldToScreenPoint(position);
		Vector3 vector2 = sNextPostion - sCurrPostion;
		Vector2 zero = Vector2.zero;
		if (vector.x < 0f || vector.x > (float)Screen.width || vector.y < 0f || vector.y > (float)Screen.height || vector.z < 0f)
		{
			criticalDis = ((criticalDis > vector.z) ? criticalDis : vector.z);
			elasticHeight = ((vector.z > 0f) ? (vector.z / criticalDis * mHeight) : 0f);
			Vector3 vector3 = sCurrPostion + new Vector3(0f, elasticHeight, 0f);
			Vector2 vector4 = Camera.main.WorldToScreenPoint(vector3);
			Vector3 position2 = vector3 + vector2.normalized * 5f;
			zero = Camera.main.WorldToScreenPoint(position2);
			Vector2 vector5 = zero - vector4;
			if (vector5.x == 0f || vector5.y == 0f)
			{
				if (vector5.x == 0f)
				{
					if (vector5.y > 0f)
					{
						zero = new Vector2(vector4.x, Screen.height);
					}
					else if (vector5.y < 0f)
					{
						zero = new Vector2(vector4.x, 0f);
					}
				}
				else if (vector5.y == 0f)
				{
					if (vector5.x < 0f)
					{
						zero = new Vector2(0f, vector4.y);
					}
					else if (vector5.x > 0f)
					{
						zero = new Vector2(Screen.width, vector4.y);
					}
				}
			}
			else if (vector5.x < 0f)
			{
				float num = Mathf.Abs((vector4.x - 0f) / vector5.x);
				Vector2 vector6 = vector4 + num * vector5;
				zero = ((vector6.y < 0f) ? new Vector2(Mathf.Abs(vector6.y / vector5.y * vector5.x), 0f) : ((!(vector6.y > (float)Screen.height)) ? (vector4 + num * vector5) : new Vector2(Mathf.Abs((vector6.y - (float)Screen.height) / vector5.y * vector5.x), Screen.height)));
			}
			else if (vector5.x > 0f)
			{
				float num2 = ((float)Screen.width - vector4.x) / vector5.x;
				Vector2 vector7 = vector4 + num2 * vector5;
				zero = ((vector7.y < 0f) ? new Vector2((float)Screen.width - vector7.y / vector5.y * vector5.x, 0f) : ((!(vector7.y > (float)Screen.height)) ? (vector4 + num2 * vector5) : new Vector2((float)Screen.width - (vector7.y - (float)Screen.height) / vector5.y * vector5.x, Screen.height)));
			}
		}
		else
		{
			zero = vector;
			criticalDis = 0f;
		}
		if (zero.x <= mIndicatorSize.x)
		{
			zero.x = mIndicatorSize.x;
		}
		else if (zero.x >= (float)Screen.width - mIndicatorSize.x)
		{
			zero.x = (float)Screen.width - mIndicatorSize.x;
		}
		if (zero.y <= mIndicatorSize.y)
		{
			zero.y = mIndicatorSize.y;
		}
		else if (zero.y >= (float)Screen.height - mIndicatorSize.y)
		{
			zero.y = (float)Screen.height - mIndicatorSize.y;
		}
		RectTransformUtility.ScreenPointToLocalPointInRectangle(mCanvasTran, zero, mUICamera, out var localPoint);
		return localPoint;
	}

	public bool Clip(float p, float q, ref float min, ref float max)
	{
		float num = 0f;
		if (p == 0f)
		{
			if (q < 0f)
			{
				return false;
			}
		}
		else if (p < 0f)
		{
			num = q / p;
			if (num > max)
			{
				return false;
			}
			if (num < min)
			{
				min = num;
			}
		}
		else if (p > 0f)
		{
			num = q / p;
			if (num < min)
			{
				return false;
			}
			if (num < max)
			{
				max = num;
			}
		}
		return true;
	}
}
