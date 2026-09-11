using System.Collections;
using System.Reflection;
using System.Runtime.InteropServices;

namespace System.Security.Policy;

[Serializable]
[MonoTODO("Serialization format not compatible with .NET")]
[ComVisible(true)]
public sealed class Evidence : ICollection, IEnumerable
{
	private class EvidenceEnumerator : IEnumerator
	{
		private IEnumerator currentEnum;

		private IEnumerator hostEnum;

		private IEnumerator assemblyEnum;

		public object Current => currentEnum.Current;

		public EvidenceEnumerator(IEnumerator hostenum, IEnumerator assemblyenum)
		{
			hostEnum = hostenum;
			assemblyEnum = assemblyenum;
			currentEnum = hostEnum;
		}

		public bool MoveNext()
		{
			if (currentEnum == null)
			{
				return false;
			}
			bool flag = currentEnum.MoveNext();
			if (!flag && hostEnum == currentEnum && assemblyEnum != null)
			{
				currentEnum = assemblyEnum;
				flag = assemblyEnum.MoveNext();
			}
			return flag;
		}

		public void Reset()
		{
			if (hostEnum != null)
			{
				hostEnum.Reset();
				currentEnum = hostEnum;
			}
			else
			{
				currentEnum = assemblyEnum;
			}
			if (assemblyEnum != null)
			{
				assemblyEnum.Reset();
			}
		}
	}

	private bool _locked;

	private ArrayList hostEvidenceList;

	private ArrayList assemblyEvidenceList;

	[Obsolete]
	public int Count
	{
		get
		{
			int num = 0;
			if (hostEvidenceList != null)
			{
				num += hostEvidenceList.Count;
			}
			if (assemblyEvidenceList != null)
			{
				num += assemblyEvidenceList.Count;
			}
			return num;
		}
	}

	public bool IsSynchronized => false;

	public object SyncRoot => this;

	internal ArrayList HostEvidenceList
	{
		get
		{
			if (hostEvidenceList == null)
			{
				hostEvidenceList = ArrayList.Synchronized(new ArrayList());
			}
			return hostEvidenceList;
		}
	}

	internal ArrayList AssemblyEvidenceList
	{
		get
		{
			if (assemblyEvidenceList == null)
			{
				assemblyEvidenceList = ArrayList.Synchronized(new ArrayList());
			}
			return assemblyEvidenceList;
		}
	}

	public Evidence()
	{
	}

	public Evidence(Evidence evidence)
	{
		if (evidence != null)
		{
			Merge(evidence);
		}
	}

	[Obsolete]
	public void AddAssembly(object id)
	{
		AssemblyEvidenceList.Add(id);
	}

	[Obsolete]
	public void AddHost(object id)
	{
		if (_locked)
		{
			_ = SecurityManager.SecurityEnabled;
		}
		HostEvidenceList.Add(id);
	}

	[Obsolete]
	public void CopyTo(Array array, int index)
	{
		int num = 0;
		if (hostEvidenceList != null)
		{
			num = hostEvidenceList.Count;
			if (num > 0)
			{
				hostEvidenceList.CopyTo(array, index);
			}
		}
		if (assemblyEvidenceList != null && assemblyEvidenceList.Count > 0)
		{
			assemblyEvidenceList.CopyTo(array, index + num);
		}
	}

	[Obsolete]
	public IEnumerator GetEnumerator()
	{
		IEnumerator hostenum = null;
		if (hostEvidenceList != null)
		{
			hostenum = hostEvidenceList.GetEnumerator();
		}
		IEnumerator assemblyenum = null;
		if (assemblyEvidenceList != null)
		{
			assemblyenum = assemblyEvidenceList.GetEnumerator();
		}
		return new EvidenceEnumerator(hostenum, assemblyenum);
	}

	public void Merge(Evidence evidence)
	{
		if (evidence == null || evidence.Count <= 0)
		{
			return;
		}
		if (evidence.hostEvidenceList != null)
		{
			foreach (object hostEvidence in evidence.hostEvidenceList)
			{
				AddHost(hostEvidence);
			}
		}
		if (evidence.assemblyEvidenceList == null)
		{
			return;
		}
		foreach (object assemblyEvidence in evidence.assemblyEvidenceList)
		{
			AddAssembly(assemblyEvidence);
		}
	}

	internal static Evidence GetDefaultHostEvidence(Assembly a)
	{
		return new Evidence();
	}
}
