using DG.Tweening.Core;

namespace DG.Tweening.Plugins.Core;

public interface IPlugSetter<T1, out T2, TPlugin, out TPlugOptions>
{
	DOGetter<T1> Getter();

	DOSetter<T1> Setter();

	T2 EndValue();

	TPlugOptions GetOptions();
}
