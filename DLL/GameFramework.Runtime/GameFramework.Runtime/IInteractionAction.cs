namespace GameFramework.Runtime;

public interface IInteractionAction
{
	void OnRequest(object sender, InteractionEventArgs args);
}
