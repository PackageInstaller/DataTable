using UnityEngine;

public class EffectScaler : MonoBehaviour
{
	public ScreenEffectAdaptationType screenEffectAdaptationType;

	public Vector2 screenSize = new Vector2(2400f, 1080f);

	private bool _isCorrection;

	public void Correction()
	{
		if (!_isCorrection)
		{
			float x = 0f;
			switch (screenEffectAdaptationType)
			{
			case ScreenEffectAdaptationType.FullWindow:
				x = (float)Screen.width * 1f / ((float)Screen.height * 1f) * 10f;
				break;
			case ScreenEffectAdaptationType.LocalWindow:
			{
				x = base.transform.localScale.x / (screenSize.x * 1f / (screenSize.y * 1f) * 10f) * ((float)Screen.width * 1f / ((float)Screen.height * 1f) * 10f);
				float x2 = base.transform.localPosition.x / (screenSize.x * 1f / (screenSize.y * 1f) * 10f) * ((float)Screen.width * 1f / ((float)Screen.height * 1f) * 10f);
				base.transform.localPosition = new Vector3(x2, base.transform.localPosition.y, 1f);
				break;
			}
			}
			base.transform.localScale = new Vector3(x, base.transform.localScale.y, 1f);
			_isCorrection = true;
		}
	}
}
