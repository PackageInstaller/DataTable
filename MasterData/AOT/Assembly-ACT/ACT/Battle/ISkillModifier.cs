namespace ACT.Battle;

public interface ISkillModifier
{
	int SkillId { get; }

	string Key { get; }

	float GetValue();

	void Init(Ability ability);
}
