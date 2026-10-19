using ACT.Config;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class TextLibraryPropPickCell : MonoBehaviour
{
	public LocalizeStringEvent content;

	public CanvasGroup canvasGroup;

	private TextLibraryContent _data;

	public void Init(TextLibraryContent tableData)
	{
		_data = tableData;
		content.StringReference.TableEntryReference = tableData.titleName;
	}

	public void ClearData()
	{
		_data = null;
	}
}
