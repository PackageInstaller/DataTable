using System.Text;
using UnityEngine;

namespace Ase;

public class BuffRecordInfo
{
	private string buffName;

	private string buffDesc;

	private float startTime;

	private float endTime;

	private float maxTime;

	private int layer;

	private int maxLayer;

	private StringBuilder baseRecord;

	private StringBuilder stateRecord;

	private StringBuilder conditionRecord;

	private StringBuilder operationRecord;

	public int buffId { get; private set; }

	public bool isSurvival { get; private set; }

	public void Init(DRBuff config)
	{
		buffId = config.Id;
		buffName = config.Name;
		buffDesc = config.Desc;
		maxTime = config.Duration;
		layer = config.InitLayer;
		maxLayer = config.MaxLayer;
		isSurvival = true;
		baseRecord = new StringBuilder();
		stateRecord = new StringBuilder();
		conditionRecord = new StringBuilder();
		operationRecord = new StringBuilder();
		InitBaseInfo();
	}

	private void InitBaseInfo()
	{
		baseRecord.AppendLine($" BuffID:\t{buffId}");
		baseRecord.AppendLine(" Name:\t" + buffName);
		baseRecord.AppendLine(" Desc:\t" + buffDesc.Trim());
	}

	public void ChangeState(bool isSurvival)
	{
		this.isSurvival = isSurvival;
		if (isSurvival)
		{
			startTime = Time.time;
		}
		else
		{
			endTime = Time.time;
		}
	}

	public void UpdateRecord(BuffUpdateRecordEnum updateRecordEnum, float value)
	{
		switch (updateRecordEnum)
		{
		case BuffUpdateRecordEnum.MaxTime:
			maxTime = value;
			break;
		case BuffUpdateRecordEnum.Layer:
			layer = (int)value;
			break;
		case BuffUpdateRecordEnum.None:
			break;
		}
	}

	public void Record(BuffRecordEnum recordEnum, string record)
	{
		switch (recordEnum)
		{
		case BuffRecordEnum.Base:
			baseRecord.AppendLine(record);
			break;
		case BuffRecordEnum.State:
			stateRecord.AppendLine(record);
			break;
		case BuffRecordEnum.Condition:
			conditionRecord.AppendLine(record);
			break;
		case BuffRecordEnum.Operation:
			operationRecord.AppendLine(record);
			break;
		case BuffRecordEnum.None:
			break;
		}
	}

	public string GetRecordInfo(BuffRecordEnum recordEnum)
	{
		return recordEnum switch
		{
			BuffRecordEnum.Base => GetBaseString(), 
			BuffRecordEnum.State => stateRecord.ToString(), 
			BuffRecordEnum.Condition => conditionRecord.ToString(), 
			BuffRecordEnum.Operation => operationRecord.ToString(), 
			_ => string.Empty, 
		};
	}

	private string GetBaseString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.AppendLine(baseRecord.ToString());
		string arg = (isSurvival ? (Time.time - startTime) : (endTime - startTime)).Round2().ToString("0.00");
		stringBuilder.AppendLine($"存活时间:\t{arg}/{maxTime.Round2()}");
		stringBuilder.AppendLine($"层数:\t{layer}/{maxLayer}");
		return stringBuilder.ToString();
	}

	public void Clear()
	{
		baseRecord?.Clear();
		stateRecord?.Clear();
		conditionRecord?.Clear();
		operationRecord?.Clear();
	}
}
