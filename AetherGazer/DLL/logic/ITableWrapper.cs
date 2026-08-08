using System;

public interface ITableWrapper
{
	int Length { get; }

	ITableWrapper this[string field] { get; }

	object Get(object field);

	void ForEach<TValue>(Action<string, TValue> action);
}
