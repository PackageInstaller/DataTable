using UnityEngine;

namespace MusicGame;

public abstract class BaseNode : MonoBehaviour
{
	public int reachTime;

	public abstract void Process(int currentTime);

	public abstract bool Check(int currentTime, int musicLength);

	public abstract NodeType GetNodeType();
}
