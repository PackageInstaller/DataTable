using System;
using System.Collections;
using System.Collections.Generic;

namespace GameFramework.DataTable;

public interface IDataTable<T> : IEnumerable<T>, IEnumerable where T : IDataRow
{
	string Name { get; }

	string FullName { get; }

	Type Type { get; }

	int Count { get; }

	T this[int id] { get; }

	T MinIdDataRow { get; }

	T MaxIdDataRow { get; }

	bool HasDataRow(int id);

	bool HasDataRow(Predicate<T> condition);

	T GetDataRow(int id);

	T GetDataRow(Predicate<T> condition);

	T[] GetDataRows(Predicate<T> condition);

	void GetDataRows(Predicate<T> condition, List<T> results);

	T[] GetDataRows(Comparison<T> comparison);

	void GetDataRows(Comparison<T> comparison, List<T> results);

	T[] GetDataRows(Predicate<T> condition, Comparison<T> comparison);

	void GetDataRows(Predicate<T> condition, Comparison<T> comparison, List<T> results);

	T[] GetAllDataRows();

	void GetAllDataRows(List<T> results);

	bool AddDataRow(string dataRowString, object userData);

	bool AddDataRow(byte[] dataRowBytes, int startIndex, int length, object userData);

	bool RemoveDataRow(int id);

	void RemoveAllDataRows();
}
