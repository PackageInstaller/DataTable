using System.Collections.Generic;
using TrueSync;

public class AdventureTimeControlManager
{
	protected readonly List<AdventureTimeControlHandler> _timeControllerHandlerPool;

	protected readonly List<AdventureTimeControlHandler> _timeControllerHandlers;

	public int timeControlHandlerPoolCapacity { get; protected set; }

	public FP finalLogicScaleValue { get; protected set; } = FP.One;

	public int TimeControlHandlerCount => _timeControllerHandlers.Count;

	public AdventureTimeControlManager(int timeControlHandlerPoolCapacity)
	{
		this.timeControlHandlerPoolCapacity = timeControlHandlerPoolCapacity;
		_timeControllerHandlerPool = new List<AdventureTimeControlHandler>(timeControlHandlerPoolCapacity);
		_timeControllerHandlers = new List<AdventureTimeControlHandler>(timeControlHandlerPoolCapacity);
	}

	public AdventureTimeControlHandler GenerateTimeControlHandler(bool isLogicTime = false)
	{
		AdventureTimeControlHandler adventureTimeControlHandler;
		if (_timeControllerHandlerPool.Count > timeControlHandlerPoolCapacity)
		{
			adventureTimeControlHandler = _timeControllerHandlerPool.get_Item(0);
			_timeControllerHandlerPool.RemoveAt(0);
		}
		else
		{
			adventureTimeControlHandler = new AdventureTimeControlHandler();
		}
		adventureTimeControlHandler.Reset();
		adventureTimeControlHandler.isLogicTime = isLogicTime;
		_timeControllerHandlers.Add(adventureTimeControlHandler);
		return adventureTimeControlHandler;
	}

	public void ReleaseTimeControlHandler(AdventureTimeControlHandler handler)
	{
		if (_timeControllerHandlers.Remove(handler))
		{
			handler.isFinish = true;
			_timeControllerHandlerPool.Add(handler);
		}
	}

	public FP Update(FP deltaTime, FP logicDeltaTime)
	{
		FP fP = FP.MaxValue;
		bool flag = false;
		FP fP2 = FP.MaxValue;
		bool flag2 = false;
		FP fP3 = FP.MinValue;
		bool flag3 = false;
		FP fP4 = FP.MinValue;
		bool flag4 = false;
		for (int num = _timeControllerHandlers.Count - 1; num >= 0; num--)
		{
			AdventureTimeControlHandler adventureTimeControlHandler = _timeControllerHandlers.get_Item(num);
			if (adventureTimeControlHandler.isFinish)
			{
				ReleaseTimeControlHandler(adventureTimeControlHandler);
			}
			else if (adventureTimeControlHandler.isLogicTime)
			{
				adventureTimeControlHandler.Update(logicDeltaTime);
				if (adventureTimeControlHandler.timeScale > FP.One)
				{
					if (adventureTimeControlHandler.timeScale > fP4)
					{
						fP4 = adventureTimeControlHandler.timeScale;
						flag4 = true;
					}
				}
				else if (adventureTimeControlHandler.timeScale < FP.One && adventureTimeControlHandler.timeScale < fP2)
				{
					fP2 = adventureTimeControlHandler.timeScale;
					flag2 = true;
				}
				if (adventureTimeControlHandler.isFinish)
				{
					ReleaseTimeControlHandler(adventureTimeControlHandler);
				}
			}
			else
			{
				adventureTimeControlHandler.Update(deltaTime);
				if (adventureTimeControlHandler.timeScale > FP.One)
				{
					if (adventureTimeControlHandler.timeScale > fP3)
					{
						fP3 = adventureTimeControlHandler.timeScale;
						flag3 = true;
					}
				}
				else if (adventureTimeControlHandler.timeScale < FP.One && adventureTimeControlHandler.timeScale < fP)
				{
					fP = adventureTimeControlHandler.timeScale;
					flag = true;
				}
				if (adventureTimeControlHandler.isFinish)
				{
					ReleaseTimeControlHandler(adventureTimeControlHandler);
				}
			}
		}
		FP result = FP.One;
		if (flag)
		{
			result = fP;
		}
		else if (flag3)
		{
			result = fP3;
		}
		finalLogicScaleValue = FP.One;
		if (flag2)
		{
			finalLogicScaleValue = fP2;
		}
		else if (flag4)
		{
			finalLogicScaleValue = fP4;
		}
		return result;
	}

	public void Stop()
	{
		for (int num = _timeControllerHandlers.Count - 1; num >= 0; num--)
		{
			AdventureTimeControlHandler adventureTimeControlHandler = _timeControllerHandlers.get_Item(num);
			adventureTimeControlHandler.Stop();
			ReleaseTimeControlHandler(adventureTimeControlHandler);
		}
		finalLogicScaleValue = FP.One;
	}

	public void StopByType(AdventureTimeControlHandler.TimeScaleType scaleType)
	{
		int num = 0;
		for (int num2 = _timeControllerHandlers.Count - 1; num2 >= 0; num2--)
		{
			AdventureTimeControlHandler adventureTimeControlHandler = _timeControllerHandlers.get_Item(num2);
			if (adventureTimeControlHandler.timeScaleType == scaleType)
			{
				num++;
				adventureTimeControlHandler.Stop();
				ReleaseTimeControlHandler(adventureTimeControlHandler);
			}
		}
		if (_timeControllerHandlers.Count == num)
		{
			finalLogicScaleValue = FP.One;
		}
	}
}
