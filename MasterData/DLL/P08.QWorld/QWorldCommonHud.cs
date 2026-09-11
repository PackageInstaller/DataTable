using TMPro;
using UnityEngine;

public class QWorldCommonHud : QWorldHudBase
{
	public static string BaseBoardPath = "TextureConfig/SandPlay/BaseBoard/{0}";

	public static string BaseIconPath = "TextureConfig/SandPlay/MiniIcon/{0}";

	public SpriteRenderer iconRender;

	public SpriteRenderer bgRender;

	public TextMeshPro jopTextComp;

	public SpriteRenderer globalBgRender;

	public SpriteRenderer globalSubBgRender;

	private string iconName;

	private string baseBoardName;

	public void SetJob(string text)
	{
		jopTextComp.text = text;
	}

	public override void OnDispose()
	{
		base.OnDispose();
		iconName = "";
		baseBoardName = "";
	}

	public override void OnHide(float rate)
	{
		if (!(bgRender == null) && !(iconRender == null))
		{
			Color color = bgRender.color;
			bgRender.color = new Color(color.r, color.g, color.b, Mathf.Lerp(color.a, 0f, rate));
			Color color2 = iconRender.color;
			iconRender.color = new Color(color2.r, color2.g, color2.b, Mathf.Lerp(color2.a, 0f, rate));
			color2 = globalBgRender.color;
			globalBgRender.color = new Color(color2.r, color2.g, color2.b, Mathf.Lerp(color2.a, 0f, rate));
			color2 = globalSubBgRender.color;
			globalSubBgRender.color = new Color(color2.r, color2.g, color2.b, Mathf.Lerp(color2.a, 0f, rate));
		}
	}

	public override void OnShow(float rate)
	{
		if (!(bgRender == null) && !(iconRender == null))
		{
			Color color = bgRender.color;
			bgRender.color = new Color(color.r, color.g, color.b, Mathf.Lerp(color.a, 1f, rate));
			Color color2 = iconRender.color;
			iconRender.color = new Color(color2.r, color2.g, color2.b, Mathf.Lerp(color2.a, 1f, rate));
			color2 = globalBgRender.color;
			globalBgRender.color = new Color(color2.r, color2.g, color2.b, Mathf.Lerp(color2.a, 1f, rate));
			color2 = globalSubBgRender.color;
			globalSubBgRender.color = new Color(color2.r, color2.g, color2.b, Mathf.Lerp(color2.a, 0.9f, rate));
		}
	}

	public override void SetData(QWAgent agent, QWHudBehaviour hudBehaviour)
	{
		base.SetData(agent, hudBehaviour);
		if (hudBehaviour.iconName.IsNotNullOrEmpty() && !hudBehaviour.iconName.Equals(iconName))
		{
			AtlasManager.GetSpriteWithoutAtlas(iconRender, string.Format(BaseIconPath, hudBehaviour.iconName));
			iconName = hudBehaviour.iconName;
		}
		if (hudBehaviour.baseBoardName.IsNotNullOrEmpty() && !hudBehaviour.baseBoardName.Equals(baseBoardName))
		{
			bgRender.sprite = AtlasManager.GetSpriteWithoutAtlas(bgRender, string.Format(BaseBoardPath, hudBehaviour.baseBoardName));
			baseBoardName = hudBehaviour.baseBoardName;
		}
		SetJob(hudBehaviour.jobName);
	}
}
