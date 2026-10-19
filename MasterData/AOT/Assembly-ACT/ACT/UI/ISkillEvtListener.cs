using ACT.Event;

namespace ACT.UI;

public interface ISkillEvtListener
{
	void OnSkillCdChange(SkillCdChangeEvt skillCdChangeEvt);

	void OnSkillCountChange(SkillCountChangeEvt skillCountChangeEvt);
}
