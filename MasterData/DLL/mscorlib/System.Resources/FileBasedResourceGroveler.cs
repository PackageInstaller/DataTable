using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Threading;

namespace System.Resources;

internal class FileBasedResourceGroveler : IResourceGroveler
{
	private ResourceManager.ResourceManagerMediator _mediator;

	public FileBasedResourceGroveler(ResourceManager.ResourceManagerMediator mediator)
	{
		_mediator = mediator;
	}

	public ResourceSet GrovelForResourceSet(CultureInfo culture, Dictionary<string, ResourceSet> localResourceSets, bool tryParents, bool createIfNotExists, ref StackCrawlMark stackMark)
	{
		string text = null;
		ResourceSet result = null;
		string resourceFileName = _mediator.GetResourceFileName(culture);
		text = FindResourceFile(culture, resourceFileName);
		if (text == null)
		{
			if (tryParents && culture.HasInvariantCultureName)
			{
				throw new MissingManifestResourceException(Environment.GetResourceString("Could not find any resources appropriate for the specified culture (or the neutral culture) on disk.") + Environment.NewLine + "baseName: " + _mediator.BaseNameField + "  locationInfo: " + ((_mediator.LocationInfo == null) ? "<null>" : _mediator.LocationInfo.FullName) + "  fileName: " + _mediator.GetResourceFileName(culture));
			}
		}
		else
		{
			result = CreateResourceSet(text);
		}
		return result;
	}

	private string FindResourceFile(CultureInfo culture, string fileName)
	{
		if (_mediator.ModuleDir != null)
		{
			string text = Path.Combine(_mediator.ModuleDir, fileName);
			if (File.Exists(text))
			{
				return text;
			}
		}
		if (File.Exists(fileName))
		{
			return fileName;
		}
		return null;
	}

	private ResourceSet CreateResourceSet(string file)
	{
		if (_mediator.UserResourceSet == null)
		{
			return new RuntimeResourceSet(file);
		}
		object[] args = new object[1] { file };
		try
		{
			return (ResourceSet)Activator.CreateInstance(_mediator.UserResourceSet, args);
		}
		catch (MissingMethodException innerException)
		{
			throw new InvalidOperationException(Environment.GetResourceString("'{0}': ResourceSet derived classes must provide a constructor that takes a String file name and a constructor that takes a Stream.", _mediator.UserResourceSet.AssemblyQualifiedName), innerException);
		}
	}
}
