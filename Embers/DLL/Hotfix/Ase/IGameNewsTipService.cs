namespace Ase;

public interface IGameNewsTipService
{
	void OpenNewsTipWindow();

	void ClearNewsTipWindow();

	bool CheckOpenScoreWindow(int id);
}
