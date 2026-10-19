using System;
using System.ComponentModel;

namespace UnityEngine.UI;

[Obsolete("Not supported anymore.", true)]
[EditorBrowsable(EditorBrowsableState.Never)]
public interface IMask
{
	RectTransform rectTransform { get; }

	bool Enabled();
}
