using UnityEngine;

public class QWorldQuestHud : QWorldHudBase
{
	public GameObject hudMain;

	public GameObject hudSide;

	public GameObject hudExplore;

	private QWorldQuestHudContext ctx;

	private EQuestType _questType;

	private GameObject _curHud => _questType switch
	{
		EQuestType.Main => hudMain, 
		EQuestType.Side => hudSide, 
		EQuestType.Explore => hudExplore, 
		_ => null, 
	};

	private SpriteRenderer _spriteRenderer => _questType switch
	{
		EQuestType.Main => ctx.mainBg, 
		EQuestType.Side => ctx.sideBg, 
		EQuestType.Explore => ctx.exploreBg, 
		_ => null, 
	};

	private SpriteRenderer _subBg => _questType switch
	{
		EQuestType.Main => ctx.mainSubBg, 
		EQuestType.Side => ctx.sideSubBg, 
		EQuestType.Explore => ctx.exploreSubBg, 
		_ => null, 
	};

	private SpriteRenderer _icon => _questType switch
	{
		EQuestType.Main => ctx.mainIcon, 
		EQuestType.Side => ctx.sideIcon, 
		EQuestType.Explore => ctx.exploreIcon, 
		_ => null, 
	};

	public override void OnHide(float rate)
	{
		if (!(_spriteRenderer == null))
		{
			Color color = _spriteRenderer.color;
			_spriteRenderer.color = new Color(color.r, color.g, color.b, Mathf.Lerp(color.a, 0f, rate));
			color = _subBg.color;
			_subBg.color = new Color(color.r, color.g, color.b, Mathf.Lerp(color.a, 0f, rate));
			color = _icon.color;
			_icon.color = new Color(color.r, color.g, color.b, Mathf.Lerp(color.a, 0f, rate));
			color = ctx.globalBg.color;
			ctx.globalBg.color = new Color(color.r, color.g, color.b, Mathf.Lerp(color.a, 0f, rate));
			color = ctx.globalSubBg.color;
			ctx.globalSubBg.color = new Color(color.r, color.g, color.b, Mathf.Lerp(color.a, 0f, rate));
		}
	}

	public override void OnShow(float rate)
	{
		if (!(_spriteRenderer == null))
		{
			Color color = _spriteRenderer.color;
			_spriteRenderer.color = new Color(color.r, color.g, color.b, Mathf.Lerp(color.a, 1f, rate));
			color = _subBg.color;
			_subBg.color = new Color(color.r, color.g, color.b, Mathf.Lerp(color.a, 0.5f, rate));
			color = _icon.color;
			_icon.color = new Color(color.r, color.g, color.b, Mathf.Lerp(color.a, 1f, rate));
			color = ctx.globalBg.color;
			ctx.globalBg.color = new Color(color.r, color.g, color.b, Mathf.Lerp(color.a, 1f, rate));
			color = ctx.globalSubBg.color;
			ctx.globalSubBg.color = new Color(color.r, color.g, color.b, Mathf.Lerp(color.a, 0.9f, rate));
		}
	}

	public override void SetData(QWAgent agent, QWHudBehaviour hudBehaviour)
	{
		base.SetData(agent, hudBehaviour);
		GameObject curHud = _curHud;
		_questType = hudBehaviour._questType;
		if (curHud != _curHud)
		{
			curHud?.SetActive(value: false);
			_curHud?.SetActive(value: true);
		}
	}
}
