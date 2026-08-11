using System.Buffers;
using System.Collections.Generic;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.Serialization;

namespace System;

[StackTraceHidden]
internal static class ThrowHelper
{
	internal static void ThrowArgumentNullException(ExceptionArgument argument)
	{
		throw CreateArgumentNullException(argument);
	}

	[MethodImpl((MethodImplOptions)8)]
	private static Exception CreateArgumentNullException(ExceptionArgument argument)
	{
		return new ArgumentNullException(argument.ToString());
	}

	internal static void ThrowArrayTypeMismatchException()
	{
		throw CreateArrayTypeMismatchException();
	}

	[MethodImpl((MethodImplOptions)8)]
	private static Exception CreateArrayTypeMismatchException()
	{
		return new ArrayTypeMismatchException();
	}

	internal static void ThrowArgumentException_DestinationTooShort()
	{
		throw CreateArgumentException_DestinationTooShort();
	}

	[MethodImpl((MethodImplOptions)8)]
	private static Exception CreateArgumentException_DestinationTooShort()
	{
		return new ArgumentException("Destination is too short.");
	}

	internal static void ThrowIndexOutOfRangeException()
	{
		throw CreateIndexOutOfRangeException();
	}

	[MethodImpl((MethodImplOptions)8)]
	private static Exception CreateIndexOutOfRangeException()
	{
		return new IndexOutOfRangeException();
	}

	internal static void ThrowArgumentOutOfRangeException()
	{
		throw CreateArgumentOutOfRangeException();
	}

	[MethodImpl((MethodImplOptions)8)]
	private static Exception CreateArgumentOutOfRangeException()
	{
		return new ArgumentOutOfRangeException();
	}

	internal static void ThrowArgumentOutOfRangeException(ExceptionArgument argument)
	{
		throw CreateArgumentOutOfRangeException(argument);
	}

	[MethodImpl((MethodImplOptions)8)]
	private static Exception CreateArgumentOutOfRangeException(ExceptionArgument argument)
	{
		return new ArgumentOutOfRangeException(argument.ToString());
	}

	internal static void ThrowArgumentOutOfRangeException_PrecisionTooLarge()
	{
		throw CreateArgumentOutOfRangeException_PrecisionTooLarge();
	}

	[MethodImpl((MethodImplOptions)8)]
	private static Exception CreateArgumentOutOfRangeException_PrecisionTooLarge()
	{
		return new ArgumentOutOfRangeException("precision", SR.Format("Precision cannot be larger than {0}.", (byte)99));
	}

	internal static void ThrowArgumentOutOfRangeException_SymbolDoesNotFit()
	{
		throw CreateArgumentOutOfRangeException_SymbolDoesNotFit();
	}

	[MethodImpl((MethodImplOptions)8)]
	private static Exception CreateArgumentOutOfRangeException_SymbolDoesNotFit()
	{
		return new ArgumentOutOfRangeException("symbol", "Format specifier was invalid.");
	}

	internal static void ThrowInvalidOperationException()
	{
		throw CreateInvalidOperationException();
	}

	[MethodImpl((MethodImplOptions)8)]
	private static Exception CreateInvalidOperationException()
	{
		return new InvalidOperationException();
	}

	internal static void ThrowInvalidOperationException_EndPositionNotReached()
	{
		throw CreateInvalidOperationException_EndPositionNotReached();
	}

	[MethodImpl((MethodImplOptions)8)]
	private static Exception CreateInvalidOperationException_EndPositionNotReached()
	{
		return new InvalidOperationException("End position was not reached during enumeration.");
	}

	internal static void ThrowArgumentOutOfRangeException_PositionOutOfRange()
	{
		throw CreateArgumentOutOfRangeException_PositionOutOfRange();
	}

	[MethodImpl((MethodImplOptions)8)]
	private static Exception CreateArgumentOutOfRangeException_PositionOutOfRange()
	{
		return new ArgumentOutOfRangeException("position");
	}

	internal static void ThrowFormatException_BadFormatSpecifier()
	{
		throw CreateFormatException_BadFormatSpecifier();
	}

	[MethodImpl((MethodImplOptions)8)]
	private static Exception CreateFormatException_BadFormatSpecifier()
	{
		return new FormatException("Format specifier was invalid.");
	}

	internal static void ThrowNotSupportedException()
	{
		throw CreateThrowNotSupportedException();
	}

	[MethodImpl((MethodImplOptions)8)]
	private static Exception CreateThrowNotSupportedException()
	{
		return new NotSupportedException();
	}

	public static bool TryFormatThrowFormatException(out int bytesWritten)
	{
		bytesWritten = 0;
		ThrowFormatException_BadFormatSpecifier();
		return false;
	}

	public static void ThrowArgumentValidationException<T>(ReadOnlySequenceSegment<T> startSegment, int startIndex, ReadOnlySequenceSegment<T> endSegment)
	{
		throw CreateArgumentValidationException(startSegment, startIndex, endSegment);
	}

	private static Exception CreateArgumentValidationException<T>(ReadOnlySequenceSegment<T> startSegment, int startIndex, ReadOnlySequenceSegment<T> endSegment)
	{
		if (startSegment == null)
		{
			return CreateArgumentNullException(ExceptionArgument.startSegment);
		}
		if (endSegment == null)
		{
			return CreateArgumentNullException(ExceptionArgument.endSegment);
		}
		if (startSegment != endSegment && startSegment.RunningIndex > endSegment.RunningIndex)
		{
			return CreateArgumentOutOfRangeException(ExceptionArgument.endSegment);
		}
		if ((uint)startSegment.Memory.Length < (uint)startIndex)
		{
			return CreateArgumentOutOfRangeException(ExceptionArgument.startIndex);
		}
		return CreateArgumentOutOfRangeException(ExceptionArgument.endIndex);
	}

	public static void ThrowArgumentValidationException(Array array, int start)
	{
		throw CreateArgumentValidationException(array, start);
	}

	private static Exception CreateArgumentValidationException(Array array, int start)
	{
		if (array == null)
		{
			return CreateArgumentNullException(ExceptionArgument.array);
		}
		if ((uint)start > (uint)array.Length)
		{
			return CreateArgumentOutOfRangeException(ExceptionArgument.start);
		}
		return CreateArgumentOutOfRangeException(ExceptionArgument.length);
	}

	public static void ThrowStartOrEndArgumentValidationException(long start)
	{
		throw CreateStartOrEndArgumentValidationException(start);
	}

	private static Exception CreateStartOrEndArgumentValidationException(long start)
	{
		if (start < 0)
		{
			return CreateArgumentOutOfRangeException(ExceptionArgument.start);
		}
		return CreateArgumentOutOfRangeException(ExceptionArgument.length);
	}

	internal static void ThrowWrongKeyTypeArgumentException(object key, Type targetType)
	{
		throw new ArgumentException(Environment.GetResourceString("The value \"{0}\" is not of type \"{1}\" and cannot be used in this generic collection.", key, targetType), "key");
	}

	internal static void ThrowWrongValueTypeArgumentException(object value, Type targetType)
	{
		throw new ArgumentException(Environment.GetResourceString("The value \"{0}\" is not of type \"{1}\" and cannot be used in this generic collection.", value, targetType), "value");
	}

	internal static void ThrowArgumentException(ExceptionResource resource)
	{
		throw new ArgumentException(Environment.GetResourceString(GetResourceName(resource)));
	}

	internal static void ThrowArgumentException(ExceptionResource resource, ExceptionArgument argument)
	{
		throw new ArgumentException(Environment.GetResourceString(GetResourceName(resource)), GetArgumentName(argument));
	}

	internal static void ThrowArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
	{
		if (CompatibilitySwitches.IsAppEarlierThanWindowsPhone8)
		{
			throw new ArgumentOutOfRangeException(GetArgumentName(argument), string.Empty);
		}
		throw new ArgumentOutOfRangeException(GetArgumentName(argument), Environment.GetResourceString(GetResourceName(resource)));
	}

	internal static void ThrowInvalidOperationException(ExceptionResource resource)
	{
		throw new InvalidOperationException(Environment.GetResourceString(GetResourceName(resource)));
	}

	internal static void ThrowSerializationException(ExceptionResource resource)
	{
		throw new SerializationException(Environment.GetResourceString(GetResourceName(resource)));
	}

	internal static void ThrowNotSupportedException(ExceptionResource resource)
	{
		throw new NotSupportedException(Environment.GetResourceString(GetResourceName(resource)));
	}

	internal static void ThrowInvalidOperationException_InvalidOperation_EnumFailedVersion()
	{
		throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
	}

	internal static void ThrowInvalidOperationException_InvalidOperation_EnumOpCantHappen()
	{
		throw new InvalidOperationException("Enumeration has either not started or has already finished.");
	}

	internal static void ThrowInvalidOperationException_InvalidOperation_EnumNotStarted()
	{
		throw new InvalidOperationException("Enumeration has not started. Call MoveNext.");
	}

	internal static void ThrowInvalidOperationException_InvalidOperation_EnumEnded()
	{
		throw new InvalidOperationException("Enumeration already finished.");
	}

	internal static void ThrowInvalidOperationException_InvalidOperation_NoValue()
	{
		throw new InvalidOperationException("Nullable object must have a value.");
	}

	private static ArgumentOutOfRangeException GetArgumentOutOfRangeException(ExceptionArgument argument, string resource)
	{
		return new ArgumentOutOfRangeException(GetArgumentName(argument), resource);
	}

	internal static void ThrowArgumentOutOfRange_IndexException()
	{
		throw GetArgumentOutOfRangeException(ExceptionArgument.index, "Index was out of range. Must be non-negative and less than the size of the collection.");
	}

	internal static void ThrowIndexArgumentOutOfRange_NeedNonNegNumException()
	{
		throw GetArgumentOutOfRangeException(ExceptionArgument.index, "Non-negative number required.");
	}

	internal static void ThrowArgumentException_Argument_InvalidArrayType()
	{
		throw new ArgumentException("Target array type is not compatible with the type of items in the collection.");
	}

	private static ArgumentException GetAddingDuplicateWithKeyArgumentException(object key)
	{
		return new ArgumentException(SR.Format("An item with the same key has already been added. Key: {0}", key));
	}

	internal static void ThrowAddingDuplicateWithKeyArgumentException(object key)
	{
		throw GetAddingDuplicateWithKeyArgumentException(key);
	}

	private static KeyNotFoundException GetKeyNotFoundException(object key)
	{
		throw new KeyNotFoundException(SR.Format("The given key '{0}' was not present in the dictionary.", key.ToString()));
	}

	internal static void ThrowKeyNotFoundException(object key)
	{
		throw GetKeyNotFoundException(key);
	}

	internal static void ThrowInvalidTypeWithPointersNotSupported(Type targetType)
	{
		throw new ArgumentException(SR.Format("Cannot use type '{0}'. Only value types without pointers or references are supported.", targetType));
	}

	internal static void ThrowInvalidOperationException_ConcurrentOperationsNotSupported()
	{
		throw GetInvalidOperationException("Operations that change non-concurrent collections must have exclusive access. A concurrent update was performed on this collection and corrupted its state. The collection's state is no longer correct.");
	}

	internal static InvalidOperationException GetInvalidOperationException(string str)
	{
		return new InvalidOperationException(str);
	}

	internal static void ThrowArraySegmentCtorValidationFailedExceptions(Array array, int offset, int count)
	{
		throw GetArraySegmentCtorValidationFailedException(array, offset, count);
	}

	private static Exception GetArraySegmentCtorValidationFailedException(Array array, int offset, int count)
	{
		if (array == null)
		{
			return GetArgumentNullException(ExceptionArgument.array);
		}
		if (offset < 0)
		{
			return GetArgumentOutOfRangeException(ExceptionArgument.offset, ExceptionResource.ArgumentOutOfRange_NeedNonNegNum);
		}
		if (count < 0)
		{
			return GetArgumentOutOfRangeException(ExceptionArgument.count, ExceptionResource.ArgumentOutOfRange_NeedNonNegNum);
		}
		return GetArgumentException(ExceptionResource.Argument_InvalidOffLen);
	}

	private static ArgumentException GetArgumentException(ExceptionResource resource)
	{
		return new ArgumentException(resource.ToString());
	}

	private static ArgumentNullException GetArgumentNullException(ExceptionArgument argument)
	{
		return new ArgumentNullException(GetArgumentName(argument));
	}

	internal static void IfNullAndNullsAreIllegalThenThrow<T>(object value, ExceptionArgument argName)
	{
		if (value == null && default(T) != null)
		{
			ThrowArgumentNullException(argName);
		}
	}

	internal static string GetArgumentName(ExceptionArgument argument)
	{
		string text = null;
		return argument switch
		{
			ExceptionArgument.array => "array", 
			ExceptionArgument.arrayIndex => "arrayIndex", 
			ExceptionArgument.capacity => "capacity", 
			ExceptionArgument.collection => "collection", 
			ExceptionArgument.list => "list", 
			ExceptionArgument.converter => "converter", 
			ExceptionArgument.count => "count", 
			ExceptionArgument.dictionary => "dictionary", 
			ExceptionArgument.dictionaryCreationThreshold => "dictionaryCreationThreshold", 
			ExceptionArgument.index => "index", 
			ExceptionArgument.info => "info", 
			ExceptionArgument.key => "key", 
			ExceptionArgument.match => "match", 
			ExceptionArgument.obj => "obj", 
			ExceptionArgument.queue => "queue", 
			ExceptionArgument.stack => "stack", 
			ExceptionArgument.startIndex => "startIndex", 
			ExceptionArgument.value => "value", 
			ExceptionArgument.name => "name", 
			ExceptionArgument.mode => "mode", 
			ExceptionArgument.item => "item", 
			ExceptionArgument.options => "options", 
			ExceptionArgument.view => "view", 
			ExceptionArgument.sourceBytesToCopy => "sourceBytesToCopy", 
			_ => string.Empty, 
		};
	}

	private static ArgumentOutOfRangeException GetArgumentOutOfRangeException(ExceptionArgument argument, ExceptionResource resource)
	{
		return new ArgumentOutOfRangeException(GetArgumentName(argument), resource.ToString());
	}

	internal static void ThrowStartIndexArgumentOutOfRange_ArgumentOutOfRange_Index()
	{
		throw GetArgumentOutOfRangeException(ExceptionArgument.startIndex, ExceptionResource.ArgumentOutOfRange_Index);
	}

	internal static void ThrowCountArgumentOutOfRange_ArgumentOutOfRange_Count()
	{
		throw GetArgumentOutOfRangeException(ExceptionArgument.count, ExceptionResource.ArgumentOutOfRange_Count);
	}

	internal static string GetResourceName(ExceptionResource resource)
	{
		string text = null;
		return resource switch
		{
			ExceptionResource.Argument_ImplementIComparable => "At least one object must implement IComparable.", 
			ExceptionResource.Argument_AddingDuplicate => "An item with the same key has already been added.", 
			ExceptionResource.ArgumentOutOfRange_BiggerThanCollection => "Larger than collection size.", 
			ExceptionResource.ArgumentOutOfRange_Count => "Count must be positive and count must refer to a location within the string/array/collection.", 
			ExceptionResource.ArgumentOutOfRange_Index => "Index was out of range. Must be non-negative and less than the size of the collection.", 
			ExceptionResource.ArgumentOutOfRange_InvalidThreshold => "The specified threshold for creating dictionary is out of range.", 
			ExceptionResource.ArgumentOutOfRange_ListInsert => "Index must be within the bounds of the List.", 
			ExceptionResource.ArgumentOutOfRange_NeedNonNegNum => "Non-negative number required.", 
			ExceptionResource.ArgumentOutOfRange_SmallCapacity => "capacity was less than the current size.", 
			ExceptionResource.Arg_ArrayPlusOffTooSmall => "Destination array is not long enough to copy all the items in the collection. Check array index and length.", 
			ExceptionResource.Arg_RankMultiDimNotSupported => "Only single dimensional arrays are supported for the requested action.", 
			ExceptionResource.Arg_NonZeroLowerBound => "The lower bound of target array must be zero.", 
			ExceptionResource.Argument_InvalidArrayType => "Target array type is not compatible with the type of items in the collection.", 
			ExceptionResource.Argument_InvalidOffLen => "Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.", 
			ExceptionResource.Argument_ItemNotExist => "The specified item does not exist in this KeyedCollection.", 
			ExceptionResource.InvalidOperation_CannotRemoveFromStackOrQueue => "Removal is an invalid operation for Stack or Queue.", 
			ExceptionResource.InvalidOperation_EmptyQueue => "Queue empty.", 
			ExceptionResource.InvalidOperation_EnumOpCantHappen => "Enumeration has either not started or has already finished.", 
			ExceptionResource.InvalidOperation_EnumFailedVersion => "Collection was modified; enumeration operation may not execute.", 
			ExceptionResource.InvalidOperation_EmptyStack => "Stack empty.", 
			ExceptionResource.InvalidOperation_EnumNotStarted => "Enumeration has not started. Call MoveNext.", 
			ExceptionResource.InvalidOperation_EnumEnded => "Enumeration already finished.", 
			ExceptionResource.NotSupported_KeyCollectionSet => "Mutating a key collection derived from a dictionary is not allowed.", 
			ExceptionResource.NotSupported_ReadOnlyCollection => "Collection is read-only.", 
			ExceptionResource.NotSupported_ValueCollectionSet => "Mutating a value collection derived from a dictionary is not allowed.", 
			ExceptionResource.NotSupported_SortedListNestedWrite => "This operation is not supported on SortedList nested types because they require modifying the original SortedList.", 
			ExceptionResource.Serialization_InvalidOnDeser => "OnDeserialization method was called while the object was not being deserialized.", 
			ExceptionResource.Serialization_MissingKeys => "The Keys for this Hashtable are missing.", 
			ExceptionResource.Serialization_NullKey => "One of the serialized keys is null.", 
			ExceptionResource.Argument_InvalidType => "The type of arguments passed into generic comparer methods is invalid.", 
			ExceptionResource.Argument_InvalidArgumentForComparison => "Type of argument is not compatible with the generic comparer.", 
			ExceptionResource.InvalidOperation_NoValue => "Nullable object must have a value.", 
			ExceptionResource.InvalidOperation_RegRemoveSubKey => "Registry key has subkeys and recursive removes are not supported by this method.", 
			ExceptionResource.Arg_RegSubKeyAbsent => "Cannot delete a subkey tree because the subkey does not exist.", 
			ExceptionResource.Arg_RegSubKeyValueAbsent => "No value exists with that name.", 
			ExceptionResource.Arg_RegKeyDelHive => "Cannot delete a registry hive's subtree.", 
			ExceptionResource.Security_RegistryPermission => "Requested registry access is not allowed.", 
			ExceptionResource.Arg_RegSetStrArrNull => "RegistryKey.SetValue does not allow a String[] that contains a null String reference.", 
			ExceptionResource.Arg_RegSetMismatchedKind => "The type of the value object did not match the specified RegistryValueKind or the object could not be properly converted.", 
			ExceptionResource.UnauthorizedAccess_RegistryNoWrite => "Cannot write to the registry key.", 
			ExceptionResource.ObjectDisposed_RegKeyClosed => "Cannot access a closed registry key.", 
			ExceptionResource.Arg_RegKeyStrLenBug => "Registry key names should not be greater than 255 characters.", 
			ExceptionResource.Argument_InvalidRegistryKeyPermissionCheck => "The specified RegistryKeyPermissionCheck value is invalid.", 
			ExceptionResource.NotSupported_InComparableType => "A type must implement IComparable<T> or IComparable to support comparison.", 
			ExceptionResource.Argument_InvalidRegistryOptionsCheck => "The specified RegistryOptions value is invalid.", 
			ExceptionResource.Argument_InvalidRegistryViewCheck => "The specified RegistryView value is invalid.", 
			_ => string.Empty, 
		};
	}
}
