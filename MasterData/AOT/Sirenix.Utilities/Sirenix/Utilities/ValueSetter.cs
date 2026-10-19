namespace Sirenix.Utilities;

public delegate void ValueSetter<InstanceType, FieldType>(ref InstanceType instance, FieldType value);
