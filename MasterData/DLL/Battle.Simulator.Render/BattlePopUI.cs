using UnityEngine;
using UnityEngine.UI;

public class BattlePopUI : MonoBehaviour
{
	public Image Battery;

	public int[] PingLevel = new int[2] { 100, 200 };

	public Color[] PingColor = new Color[3]
	{
		Color.green,
		Color.yellow,
		Color.red
	};

	public Image[] PingImage;

	public Text PingText;

	private float _updateTime = 2f;

	public void Start()
	{
		base.gameObject.SetActive(value: false);
	}

	public void Update()
	{
		_updateTime += Time.deltaTime;
		if (_updateTime < 3f)
		{
			return;
		}
		_updateTime = 0f;
		int ping = ClientSimulator.Instance.GetPing();
		if (PingLevel == null || PingColor == null || PingImage == null)
		{
			return;
		}
		int num = 0;
		for (int i = 0; i < PingLevel.Length; i++)
		{
			if (ping <= PingLevel[i])
			{
				num = i;
				break;
			}
			num++;
		}
		Color color = Color.white;
		if (PingColor.Length > num)
		{
			color = PingColor[num];
		}
		for (int j = 0; j < PingImage.Length; j++)
		{
			if (j < PingImage.Length - num)
			{
				PingImage[j].enabled = true;
				PingImage[j].color = color;
			}
			else
			{
				PingImage[j].enabled = false;
			}
		}
		if (PingText != null)
		{
			PingText.text = $"<size=16>{ping}</size>ms";
			PingText.color = color;
		}
	}
}
