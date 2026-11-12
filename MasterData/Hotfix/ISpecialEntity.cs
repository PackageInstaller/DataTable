public interface ISpecialEntity
{
	AdventureActor Owner { get; }

	void Setup(AdventureActor owner);

	void Finish();
}
