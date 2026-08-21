namespace System;

internal enum LazyState
{
	NoneViaConstructor,
	NoneViaFactory,
	NoneException,
	PublicationOnlyViaConstructor,
	PublicationOnlyViaFactory,
	PublicationOnlyWait,
	PublicationOnlyException,
	ExecutionAndPublicationViaConstructor,
	ExecutionAndPublicationViaFactory,
	ExecutionAndPublicationException
}
