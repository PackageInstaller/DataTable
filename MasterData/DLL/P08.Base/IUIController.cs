using System;

public interface IUIController
{
	void SetSelectedIndex(int newIndex, bool immediately = false);

	void AddSelectChangeListener(Action<int> handler);

	void RemoveSelectChangeHandler(Action<int> handler);

	int GetStateIndex(string stateValue);

	void SetSelectedState(string value, bool immediately = false);

	string GetSelectedState();

	string GetName();
}
