using System.Collections.Generic;
using System.Text;
using Ase.ECS;

namespace Ase;

public class BattleProgressPropertyMonitor
{
	public class PropertyMonitorInfo
	{
		public int entityId;

		public int configId;

		private Dictionary<string, float> propertyMaxRecordDic;

		public PropertyMonitorInfo(int entityId, int configId)
		{
			this.entityId = entityId;
			this.configId = configId;
			propertyMaxRecordDic = new Dictionary<string, float>();
		}

		public void OnRecordPropertyValue(string propertyName, float value)
		{
			if (!propertyMaxRecordDic.TryGetValue(propertyName, out var value2))
			{
				propertyMaxRecordDic.Add(propertyName, value);
			}
			else if (value > value2)
			{
				propertyMaxRecordDic[propertyName] = value;
			}
		}

		public override string ToString()
		{
			if (propertyMaxRecordDic == null)
			{
				return base.ToString();
			}
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.AppendLine($"实体ID:{entityId} 实体配置ID:{configId} 属性获取最大值 =>");
			foreach (KeyValuePair<string, float> item in propertyMaxRecordDic)
			{
				stringBuilder.AppendLine($"属性名:{item.Key} 最大值:{item.Value}");
			}
			stringBuilder.AppendLine();
			return stringBuilder.ToString();
		}
	}

	private static BattleProgressPropertyMonitor instance;

	public Dictionary<int, PropertyMonitorInfo> infoDic;

	public static BattleProgressPropertyMonitor Instance
	{
		get
		{
			if (instance == null)
			{
				instance = new BattleProgressPropertyMonitor();
			}
			return instance;
		}
	}

	private BattleProgressPropertyMonitor()
	{
		infoDic = new Dictionary<int, PropertyMonitorInfo>();
	}

	private void OnRecordPropertyValue(BaseEntity entity, string propertyName, float value)
	{
		if (entity != null)
		{
			if (!infoDic.TryGetValue(entity.Id, out var value2))
			{
				value2 = new PropertyMonitorInfo(entity.Id, entity.EntityId);
				infoDic.Add(entity.Id, value2);
			}
			else
			{
				value2.OnRecordPropertyValue(propertyName, value);
			}
		}
	}

	public override string ToString()
	{
		if (infoDic == null || infoDic.Count == 0)
		{
			return base.ToString();
		}
		StringBuilder stringBuilder = new StringBuilder();
		foreach (PropertyMonitorInfo value in infoDic.Values)
		{
			stringBuilder.AppendLine(value.ToString());
		}
		return stringBuilder.ToString();
	}

	public void OnClear()
	{
		infoDic?.Clear();
	}

	public static void RecordPropertyValue(BaseEntity entity, string propertyName, float value)
	{
		if (BattleProgressLog.IsOpen)
		{
			Instance.OnRecordPropertyValue(entity, propertyName, value);
		}
	}

	public static string GetString()
	{
		if (!BattleProgressLog.IsOpen)
		{
			return string.Empty;
		}
		return Instance.ToString();
	}

	public static void Clear()
	{
		if (BattleProgressLog.IsOpen)
		{
			Instance.OnClear();
		}
	}
}
