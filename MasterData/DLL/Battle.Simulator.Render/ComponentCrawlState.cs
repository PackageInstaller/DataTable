public class ComponentCrawlState : CMonoBehaviour
{
	public bool isCrawl;

	public override void ResetBehavior()
	{
		base.ResetBehavior();
		isCrawl = false;
	}
}
