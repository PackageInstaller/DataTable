using System.Collections.Generic;

namespace GameFramework.DataNode;

public interface IDataNode
{
	string Name { get; }

	string FullName { get; }

	IDataNode Parent { get; }

	int ChildCount { get; }

	T GetData<T>() where T : DataNodeVariable;

	DataNodeVariable GetData();

	void SetData<T>(T data) where T : DataNodeVariable;

	void SetData(DataNodeVariable data);

	bool HasChild(int index);

	bool HasChild(string name);

	IDataNode GetChild(int index);

	IDataNode GetChild(string name);

	IDataNode GetOrAddChild(string name);

	IDataNode[] GetAllChild();

	void GetAllChild(List<IDataNode> results);

	void RemoveChild(int index);

	void RemoveChild(string name);

	void Clear();

	new string ToString();

	string ToDataString();
}
