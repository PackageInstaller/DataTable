using UnityEngine;
using UnityEngine.UI;

public class FloBlurPlay : MonoBehaviour, IFloGameplay
{
	public float maxBlur = 5f;

	public float maxAxisValue = 50f;

	public float winValue = 5f;

	[SerializeField]
	private Image _playImage;

	private UIBlurMipMap _blurCom;

	private float _blur = 2f;

	private float _x;

	private float _y;

	private float _value;

	private void Start()
	{
		if (_playImage != null)
		{
			_blurCom = _playImage.GetComponent<UIBlurMipMap>();
		}
	}

	private void LateUpdate()
	{
		if (_blurCom != null)
		{
			_blurCom.mipLevel = Mathf.Clamp(_blur, 0f, 8f);
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
		float num = 2f * maxAxisValue;
		_x = gameData.value1 * maxAxisValue;
		_y = gameData.value2 * maxAxisValue;
		gameData.xValue = _x;
		gameData.yValue = _y;
		_value = _x + _y;
		bool flag = _value < winValue;
		float num2 = _value / num;
		gameData.isWin = flag;
		gameData.percent = num2;
		if (flag)
		{
			_blur = 0f;
		}
		else
		{
			_blur = Mathf.Lerp(0f, maxBlur, num2);
		}
	}

	public void PrintDebugMsg()
	{
		Debug.Log($"FloBlurPlay: (x,y) = {_x},{_y}, _value = {_value}, _blur = {_blur}");
	}
}
