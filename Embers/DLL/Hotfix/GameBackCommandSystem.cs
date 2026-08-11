using System.Collections.Concurrent;
using Ase;
using Ase.ECS;
using GameFramework;

public class GameBackCommandSystem : BaseSystem
{
	public int maxFrame;

	private ConcurrentDictionary<uint, VerityServerFrameData> _serverCommands = new ConcurrentDictionary<uint, VerityServerFrameData>();

	private ConcurrentDictionary<uint, VerityServerFrameData> _serverAICommands = new ConcurrentDictionary<uint, VerityServerFrameData>();

	protected override bool IsLogicSystem => true;

	public int CommandCount => _serverCommands.Count;

	public void SetMaxFrame(int maxFrame)
	{
		this.maxFrame = maxFrame;
	}

	public void ReceiveBattleFrameResponse(GlobalBattleFrame packet)
	{
		if (!_serverCommands.TryGetValue((uint)packet.Tick, out var value))
		{
			value = ReferencePool.Acquire<VerityServerFrameData>();
			_serverCommands.TryAdd((uint)packet.Tick, value);
		}
		foreach (OneBattleFrameMessage battleFrame in packet.BattleFrames)
		{
			MsgPlayerInput msgPlayerInput = ReferencePool.Acquire<MsgPlayerInput>();
			msgPlayerInput.RefreshData(battleFrame, packet.Tick);
			value.SetData(msgPlayerInput);
		}
		world.RealServerTick = packet.Tick;
	}

	public void ReceiveBattleFrameResponse(SingleBattleFrameMessage packet)
	{
		if (!_serverCommands.TryGetValue((uint)packet.Tick, out var value))
		{
			value = ReferencePool.Acquire<VerityServerFrameData>();
			_serverCommands.TryAdd((uint)packet.Tick, value);
		}
		value.SetData(packet);
		world.RealServerTick = packet.Tick;
	}

	public VerityServerFrameData GetServerCommand(uint tick)
	{
		if (_serverCommands.TryGetValue(tick, out var value))
		{
			return value;
		}
		return null;
	}
}
