namespace Sirenix.Serialization.Utilities;

internal delegate void ValueSetter<InstanceType, FieldType>(ref InstanceType instance, FieldType value);
