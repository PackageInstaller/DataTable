using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace Ase;

public interface IBFBEService
{
	UniTask<bool> RequestUseDatas();

	UniTask<bool> RequestDatas();

	UniTask<(List<int>, List<int>)> GetBattleSetEmojiSettingRst();

	(List<int>, List<int>) GetBattleSetEmojiSetting();

	UniTask<bool> SetBattleSetEmojiSetting(List<int> RoundEmojis, List<int> FightEventEmojis);

	UniTask<(List<int>, int, int)> GetDecorationSettingRst();

	List<int> GetCardFrameSet();

	int GetChatBubble();

	UniTask<bool> SetCardFrameSetting(List<int> cardFrames);

	UniTask<bool> SetChatBubbleSetting(int bubble);

	UniTask<bool> SetIndicatorSetting(int indicator);

	int GetIndicatorSetting();

	UniTask<bool> GetHeroSkillCamreaSkin(RoleDecorateEnum type = RoleDecorateEnum.HeroSkillCameraSkin);

	UniTask<bool> SetOrChangeSkillSkinInfoRst(int heroId, int skillSkinId);

	UniTask<bool> UnlockSkillSkinInfoRst(int skillSkinId);

	bool HeroSkillCameraSkinIsLock(int skillSkinId);
}
