namespace Bamboo.ECS;

public interface IComponent
{
	bool NeedPrint { get; }

	void OnGet();

	void OnRelease();

	void Init(Entity owner);

	string GetPrintLog();
}
