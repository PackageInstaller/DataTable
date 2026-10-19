using System.Collections.Generic;
using ACT;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.UI;
using Fundamental;
using UnityEngine;

public class CardDrawBgComponent : MonoBehaviour
{
	public int GachaPoolId;

	public BetterAnimation betterAnimation;

	public string SoundResourceName;

	public List<Character> Characters;

	public List<Character> GetCharactersByTrialCharacterList(IEnumerable<int> trialCharacterList)
	{
		Characters = CharacterDataHelper.CreateTrialCharacterTeamByProbationIds(trialCharacterList);
		return Characters;
	}

	private void Start()
	{
	}

	public virtual void Init()
	{
		Gacha data = CoreUtils.GetData(GachaPoolId, RuntimeConfigs.data.gachas);
		GetCharactersByTrialCharacterList(data.targetCharacterShows);
	}

	private void Update()
	{
	}

	public void JumpToCharacter(int defaultCharacterId)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CHARACTER, new CharacterViewData
		{
			DisplayCharacters = new List<Character>(Characters),
			defaultCharacterId = defaultCharacterId
		});
	}
}
