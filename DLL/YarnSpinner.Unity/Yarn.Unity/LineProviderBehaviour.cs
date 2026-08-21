using System.Collections.Generic;
using UnityEngine;

namespace Yarn.Unity;

public abstract class LineProviderBehaviour : MonoBehaviour
{
	public YarnProject YarnProject { get; set; }

	public virtual bool LinesAvailable => true;

	public abstract string LocaleCode { get; }

	public abstract LocalizedLine GetLocalizedLine(Line line);

	public virtual void PrepareForLines(IEnumerable<string> lineIDs)
	{
	}

	public virtual void Start()
	{
	}
}
