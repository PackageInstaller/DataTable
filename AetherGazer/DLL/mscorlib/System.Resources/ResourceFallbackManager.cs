using System.Collections;
using System.Collections.Generic;
using System.Globalization;

namespace System.Resources;

internal class ResourceFallbackManager : IEnumerable<CultureInfo>, IEnumerable
{
	private CultureInfo m_startingCulture;

	private CultureInfo m_neutralResourcesCulture;

	private bool m_useParents;

	internal ResourceFallbackManager(CultureInfo startingCulture, CultureInfo neutralResourcesCulture, bool useParents)
	{
		if (startingCulture != null)
		{
			m_startingCulture = startingCulture;
		}
		else
		{
			m_startingCulture = CultureInfo.CurrentUICulture;
		}
		m_neutralResourcesCulture = neutralResourcesCulture;
		m_useParents = useParents;
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	public IEnumerator<CultureInfo> GetEnumerator()
	{
		bool reachedNeutralResourcesCulture = false;
		CultureInfo currentCulture = m_startingCulture;
		do
		{
			if (m_neutralResourcesCulture != null && currentCulture.Name == m_neutralResourcesCulture.Name)
			{
				yield return CultureInfo.InvariantCulture;
				reachedNeutralResourcesCulture = true;
				break;
			}
			yield return currentCulture;
			currentCulture = currentCulture.Parent;
		}
		while (m_useParents && !currentCulture.HasInvariantCultureName);
		if (m_useParents && !m_startingCulture.HasInvariantCultureName && !reachedNeutralResourcesCulture)
		{
			yield return CultureInfo.InvariantCulture;
		}
	}
}
