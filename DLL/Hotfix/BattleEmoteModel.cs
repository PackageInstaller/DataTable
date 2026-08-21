using Ase;
using GameFramework.Runtime;
using UnityEngine;

public class BattleEmoteModel : ViewModelBase
{
	private InteractionRequest _selectRequest;

	public int EmoteConfigId;

	private string _iconPath;

	private Sprite _sprite;

	private float _startDeg;

	private float _endDeg;

	private bool _isNull;

	private BattleEmoteViewModel _battleEmoteViewModel;

	public IInteractionRequest SelectRequest => _selectRequest;

	public Sprite EmoteSprite => _sprite;

	public float StartDeg => _startDeg;

	public float EndDeg => _endDeg;

	public bool IsNull => _isNull;

	public string EmoteIcon
	{
		get
		{
			return _iconPath;
		}
		private set
		{
			Set(ref _iconPath, value, "EmoteIcon");
		}
	}

	public BattleEmoteModel()
	{
	}

	public BattleEmoteModel(DRBattleEmote drBattleEmote)
	{
		if (drBattleEmote == null || string.IsNullOrEmpty(drBattleEmote.ResPath))
		{
			_isNull = true;
			return;
		}
		EmoteConfigId = drBattleEmote.Id;
		EmoteIcon = drBattleEmote.ResPath;
		InitAssets();
		_isNull = false;
	}

	private async void InitAssets()
	{
		_sprite = await GameEntry.Resource.LoadSpriteAsync(AssetUtility.GetTextureAsset(EmoteIcon), "World");
		_selectRequest = new InteractionRequest();
	}

	public void Init(int emoteIndex, BattleEmoteViewModel battleEmoteViewModel)
	{
		if (!_isNull)
		{
			_battleEmoteViewModel = battleEmoteViewModel;
			float num = 360f / (float)battleEmoteViewModel.BattleEmoteModels.Count;
			_endDeg = num * (float)emoteIndex;
			_startDeg = _endDeg - num;
		}
	}

	public void Init(BattleEmoteViewModel battleEmoteViewModel)
	{
		if (!_isNull)
		{
			_battleEmoteViewModel = battleEmoteViewModel;
		}
	}

	public void SelectEmote()
	{
		if (!_isNull)
		{
			_battleEmoteViewModel.SelectEmote(EmoteConfigId);
		}
	}

	public void ClearSelect()
	{
		if (!_isNull)
		{
			_battleEmoteViewModel.SelectEmote(0);
		}
	}
}
