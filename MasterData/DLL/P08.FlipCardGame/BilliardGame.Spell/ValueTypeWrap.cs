namespace BilliardGame.Spell;

public class ValueTypeWrap<T> : IValue<T>, ValueWrapInterface
{
	public static ValueTypeWrap<T> Create(T value)
	{
		ValueTypeWrap<T> valueTypeWrap = ObjectPool<ValueTypeWrap<T>>.Get();
		valueTypeWrap.Value = value;
		return valueTypeWrap;
	}

	public void Dispose()
	{
		base.Value = default(T);
		ObjectPool<ValueTypeWrap<T>>.Release(this);
	}
}
