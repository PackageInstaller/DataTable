using UnityEngine;
using UnityEngine.UI;

public class ScoreTips : MonoBehaviour
{
	public Text _AllText;

	public Text _Uptext;

	public Image _bg;

	public GameObject _UpGameObject;

	private Vector3 _originPos;

	private Vector3 moveDelta = Vector3.zero;

	private int allScore;

	public float _UpTime = 3f;

	private float curTime;

	private bool startUpdate;

	public AnimationCurve curve = new AnimationCurve();

	public AnimationCurve Acurve = new AnimationCurve();

	private void Awake()
	{
		if (_AllText != null)
		{
			_AllText.text = "0";
		}
		if (_Uptext != null)
		{
			_Uptext.text = "0";
		}
		if (_UpGameObject != null)
		{
			_originPos = _UpGameObject.transform.localPosition;
		}
		_UpGameObject.SetActive(value: false);
	}

	public void AddAllValue(int text)
	{
		allScore += text;
		_AllText.text = WorldStateManager.GetNumberString(allScore);
	}

	public void AddValue(int text)
	{
		AddAllValue(text);
		ReStartUptext(text);
	}

	public void ReStartUptext(int text)
	{
		_UpGameObject.transform.localPosition = _originPos;
		curTime = 0f;
		startUpdate = true;
		_Uptext.text = WorldStateManager.GetNumberString(text);
		if (!_UpGameObject.activeSelf)
		{
			_UpGameObject.SetActive(value: true);
		}
	}

	private void Update()
	{
		if (!startUpdate)
		{
			if (_UpGameObject.activeSelf)
			{
				_UpGameObject.SetActive(value: false);
			}
			return;
		}
		curTime += Time.deltaTime;
		if (curTime >= _UpTime)
		{
			startUpdate = false;
		}
		float time = curTime / _UpTime;
		moveDelta.y = curve.Evaluate(time) * (float)Screen.height;
		_UpGameObject.transform.localPosition = _originPos + moveDelta;
		Color color = _bg.color;
		float a = (color.a = Acurve.Evaluate(time));
		_bg.color = color;
		color = _Uptext.color;
		color.a = a;
		_Uptext.color = color;
	}
}
