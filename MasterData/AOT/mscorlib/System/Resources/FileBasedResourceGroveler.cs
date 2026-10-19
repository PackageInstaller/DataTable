namespace System.Resources;

internal class FileBasedResourceGroveler : IResourceGroveler
{
	private ResourceManager.ResourceManagerMediator _mediator;

	public FileBasedResourceGroveler(ResourceManager.ResourceManagerMediator mediator)
	{
		_mediator = mediator;
	}
}
