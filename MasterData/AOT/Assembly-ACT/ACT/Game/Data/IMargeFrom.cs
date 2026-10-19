namespace ACT.Game.Data;

public interface IMargeFrom<T>
{
	void MargeFrom(T other);

	void Refresh();

	int GetId();
}
