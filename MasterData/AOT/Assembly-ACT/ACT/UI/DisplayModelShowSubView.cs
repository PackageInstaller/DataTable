using ACT.Core;
using Bamboo.ImageCenter;

namespace ACT.UI;

public class DisplayModelShowSubView : SubUIView, ICharacterSubView, ISubUIView, IBaseUIComponent
{
	private bool _afterAnimation;

	private int _characterId;

	private ImageAssetStation _Station;

	public CharacterView CharacterView { get; private set; }

	public int Depth => 2;

	public ICharacterSubView lastSubView { get; set; }

	public bool FreezeCharacterOSA => true;

	public CharacterViewScene.CvSceneType SceneType => CharacterViewScene.CvSceneType.DisplayModelShow;

	public new object Context { get; set; }

	public bool AfterAnimation
	{
		get
		{
			return _afterAnimation;
		}
		set
		{
			_afterAnimation = value;
			if (value)
			{
				((ICharacterSubView)this).SendAfterAnimationEvent();
			}
		}
	}

	public void Init(CharacterView characterView)
	{
		CharacterView = characterView;
	}

	public void Show(int characterId, ImageAssetStation station, ICharacterSource characterSource)
	{
		_characterId = characterId;
		gameObject.SetActive(value: true);
		_Station = station;
		Refresh(characterId);
	}

	public void Hide()
	{
		gameObject.SetActive(value: false);
	}

	public void Freeze()
	{
		gameObject.SetActive(value: false);
	}

	public void UnFreeze(int characterId)
	{
		gameObject.SetActive(value: true);
	}

	public void OnSelectCharacter(ICharacterSource characterSource)
	{
		Refresh(_characterId = characterSource.Id());
	}

	private void Refresh(int characterId)
	{
	}
}
