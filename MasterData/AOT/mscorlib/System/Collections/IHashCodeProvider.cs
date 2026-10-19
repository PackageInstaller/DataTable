namespace System.Collections;

[Obsolete("Please use IEqualityComparer instead.")]
public interface IHashCodeProvider
{
	int GetHashCode(object obj);
}
