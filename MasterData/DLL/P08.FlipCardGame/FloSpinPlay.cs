using System;
using UnityEngine;
using UnityEngine.UI;

public class FloSpinPlay : MonoBehaviour, IFloGameplay
{
	public float maxBlur = 5f;

	public float maxDistance = 15f;

	public float maxSpinSpeed = 0.1f;

	public float minSpinSpeed = 0.001f;

	public float radiusMul = 0.1f;

	public float maxAxisValue = 20f;

	public float winValue = 3f;

	[SerializeField]
	private Image _centerImage;

	[SerializeField]
	private Image[] _offsetImages;

	private UIBlurMipMap[] _blurCom;

	private float _x;

	private float _y;

	private float _value;

	private float _radius;

	private float _speed;

	private Vector3 _centerPos;

	private float _curAngle;

	private float _blur;

	private const float _2sqrt2 = 2.828427f;

	private void Start()
	{
		_blurCom = new UIBlurMipMap[1 + _offsetImages.Length];
		_blurCom[0] = _centerImage.GetComponent<UIBlurMipMap>();
		for (int i = 0; i < _offsetImages.Length; i++)
		{
			Image image = _offsetImages[i];
			_blurCom[i + 1] = image.GetComponent<UIBlurMipMap>();
		}
		_centerPos = _centerImage.rectTransform.localPosition;
	}

	private void LateUpdate()
	{
		float num = MathF.PI * 2f / (float)_offsetImages.Length;
		float radius = _radius;
		float num2 = 2.828427f * maxDistance;
		Vector2 viewSpreadSize = (base.transform as RectTransform).rect.size + new Vector2(num2, num2);
		bool flag = radius == 0f;
		for (int i = 0; i < _offsetImages.Length; i++)
		{
			float f = _curAngle + num * (float)i;
			Image image = _offsetImages[i];
			RectTransform rectTransform = image.rectTransform;
			Vector3 vector = new Vector3(Mathf.Cos(f) * radius, Mathf.Sin(f) * radius, 1f);
			rectTransform.localPosition = _centerPos + vector;
			AdjustImgSize(rectTransform, viewSpreadSize);
			image.enabled = !flag;
			if (i == 0)
			{
				Color color = image.color;
				color.a = 1f;
				image.color = color;
			}
		}
		AdjustImgSize(_centerImage.rectTransform, viewSpreadSize);
		_curAngle += _speed;
		UIBlurMipMap[] blurCom = _blurCom;
		for (int j = 0; j < blurCom.Length; j++)
		{
			blurCom[j].mipLevel = Mathf.Clamp(_blur, 0f, 8f);
		}
	}

	private void AdjustImgSize(RectTransform rectTrans, Vector2 viewSpreadSize)
	{
		Vector2 size = rectTrans.rect.size;
		Vector2 vector = viewSpreadSize / size;
		float num = Mathf.Max(vector.x, vector.y);
		if (num > 0f)
		{
			rectTrans.localScale = new Vector3(num, num, 1f);
		}
	}

	public void StartGame(FloGameData gameData)
	{
	}

	public void StopGame(FloGameData gameData)
	{
	}

	public void Tick(FloGameData gameData)
	{
		float num = Mathf.Sqrt(2f * maxAxisValue * maxAxisValue) / 2f;
		_x = gameData.value1 * maxAxisValue;
		_y = gameData.value2 * maxAxisValue;
		gameData.xValue = _x;
		gameData.yValue = _y;
		_value = Mathf.Sqrt(_x * _x + _y * _y) / 2f;
		_radius = _value * radiusMul;
		bool flag = _value < winValue;
		float t = (gameData.percent = _value / num);
		gameData.isWin = flag;
		if (flag)
		{
			_radius = 0f;
			_speed = 0f;
			_blur = 0f;
		}
		else
		{
			_radius = Mathf.Lerp(0f, maxDistance, t);
			_speed = Mathf.Lerp(minSpinSpeed, maxSpinSpeed, t);
			_blur = Mathf.Lerp(0f, maxBlur, t);
		}
	}

	public void PrintDebugMsg()
	{
		Debug.Log($"FloSpinPlay: (x,y) = {_x},{_y}, _value = {_value}, _radius = {_radius}, _speed = {_speed}, _curAngle = {_curAngle}, _blur = {_blur}");
	}
}
