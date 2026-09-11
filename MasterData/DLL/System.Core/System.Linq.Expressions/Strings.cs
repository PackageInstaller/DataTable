namespace System.Linq.Expressions;

internal static class Strings
{
	internal static string ReducibleMustOverrideReduce => "reducible nodes must override Expression.Reduce()";

	internal static string MustReduceToDifferent => "node cannot reduce to itself or null";

	internal static string ReducedNotCompatible => "cannot assign from the reduced node type to the original node type";

	internal static string SetterHasNoParams => "Setter must have parameters.";

	internal static string PropertyCannotHaveRefType => "Property cannot have a managed pointer type.";

	internal static string IndexesOfSetGetMustMatch => "Indexing parameters of getter and setter must match.";

	internal static string AccessorsCannotHaveVarArgs => "Accessor method should not have VarArgs.";

	internal static string AccessorsCannotHaveByRefArgs => "Accessor indexes cannot be passed ByRef.";

	internal static string BoundsCannotBeLessThanOne => "Bounds count cannot be less than 1";

	internal static string TypeMustNotBeByRef => "Type must not be ByRef";

	internal static string TypeMustNotBePointer => "Type must not be a pointer type";

	internal static string SetterMustBeVoid => "Setter should have void type.";

	internal static string PropertyTypeMustMatchGetter => "Property type must match the value type of getter";

	internal static string PropertyTypeMustMatchSetter => "Property type must match the value type of setter";

	internal static string BothAccessorsMustBeStatic => "Both accessors must be static.";

	internal static string OnlyStaticFieldsHaveNullInstance => "Static field requires null instance, non-static field requires non-null instance.";

	internal static string OnlyStaticPropertiesHaveNullInstance => "Static property requires null instance, non-static property requires non-null instance.";

	internal static string OnlyStaticMethodsHaveNullInstance => "Static method requires null instance, non-static method requires non-null instance.";

	internal static string PropertyTypeCannotBeVoid => "Property cannot have a void type.";

	internal static string InvalidUnboxType => "Can only unbox from an object or interface type to a value type.";

	internal static string ExpressionMustBeWriteable => "Expression must be writeable";

	internal static string ArgumentMustNotHaveValueType => "Argument must not have a value type.";

	internal static string MustBeReducible => "must be reducible node";

	internal static string AllTestValuesMustHaveSameType => "All test values must have the same type.";

	internal static string AllCaseBodiesMustHaveSameType => "All case bodies and the default body must have the same type.";

	internal static string DefaultBodyMustBeSupplied => "Default body must be supplied if case bodies are not System.Void.";

	internal static string LabelMustBeVoidOrHaveExpression => "Label type must be System.Void if an expression is not supplied";

	internal static string LabelTypeMustBeVoid => "Type must be System.Void for this label argument";

	internal static string QuotedExpressionMustBeLambda => "Quoted expression must be a lambda";

	internal static string CollectionModifiedWhileEnumerating => "Collection was modified; enumeration operation may not execute.";

	internal static string CollectionReadOnly => "Collection is read-only.";

	internal static string BindingCannotBeNull => "Bind cannot return null.";

	internal static string ArgumentTypeCannotBeVoid => "Argument type cannot be void";

	internal static string NoOrInvalidRuleProduced => "No or Invalid rule produced";

	internal static string TypeMustBeDerivedFromSystemDelegate => "Type must be derived from System.Delegate";

	internal static string FirstArgumentMustBeCallSite => "First argument of delegate must be CallSite";

	internal static string StartEndMustBeOrdered => "Start and End must be well ordered";

	internal static string FaultCannotHaveCatchOrFinally => "fault cannot be used with catch or finally clauses";

	internal static string TryMustHaveCatchFinallyOrFault => "try must have at least one catch, finally, or fault clause";

	internal static string BodyOfCatchMustHaveSameTypeAsBodyOfTry => "Body of catch must have the same type as body of try.";

	internal static string ConversionIsNotSupportedForArithmeticTypes => "Conversion is not supported for arithmetic types without operator overloading.";

	internal static string ArgumentMustBeArray => "Argument must be array";

	internal static string ArgumentMustBeBoolean => "Argument must be boolean";

	internal static string ArgumentMustBeFieldInfoOrPropertyInfo => "Argument must be either a FieldInfo or PropertyInfo";

	internal static string ArgumentMustBeFieldInfoOrPropertyInfoOrMethod => "Argument must be either a FieldInfo, PropertyInfo or MethodInfo";

	internal static string ArgumentMustBeInstanceMember => "Argument must be an instance member";

	internal static string ArgumentMustBeInteger => "Argument must be of an integer type";

	internal static string ArgumentMustBeArrayIndexType => "Argument for array index must be of type Int32";

	internal static string ArgumentMustBeSingleDimensionalArrayType => "Argument must be single-dimensional, zero-based array type";

	internal static string ArgumentTypesMustMatch => "Argument types do not match";

	internal static string CoalesceUsedOnNonNullType => "Coalesce used with type that cannot be null";

	internal static string IncorrectNumberOfIndexes => "Incorrect number of indexes";

	internal static string IncorrectNumberOfLambdaDeclarationParameters => "Incorrect number of parameters supplied for lambda declaration";

	internal static string IncorrectNumberOfMembersForGivenConstructor => " Incorrect number of members for constructor";

	internal static string IncorrectNumberOfArgumentsForMembers => "Incorrect number of arguments for the given members ";

	internal static string LambdaTypeMustBeDerivedFromSystemDelegate => "Lambda type parameter must be derived from System.MulticastDelegate";

	internal static string ElementInitializerMethodNotAdd => "Element initializer method must be named 'Add'";

	internal static string ElementInitializerMethodWithZeroArgs => "Element initializer method must have at least 1 parameter";

	internal static string ElementInitializerMethodStatic => "Element initializer method must be an instance method";

	internal static string UnknownBindingType => "Unknown binding type";

	internal static string IncorrectNumberOfTypeArgsForFunc => "An incorrect number of type arguments were specified for the declaration of a Func type.";

	internal static string IncorrectNumberOfTypeArgsForAction => "An incorrect number of type arguments were specified for the declaration of an Action type.";

	internal static string ArgumentCannotBeOfTypeVoid => "Argument type cannot be System.Void.";

	internal static string ControlCannotLeaveFinally => "Control cannot leave a finally block.";

	internal static string ControlCannotLeaveFilterTest => "Control cannot leave a filter test.";

	internal static string ControlCannotEnterTry => "Control cannot enter a try block.";

	internal static string ControlCannotEnterExpression => "Control cannot enter an expression--only statements can be jumped into.";

	internal static string RethrowRequiresCatch => "Rethrow statement is valid only inside a Catch block.";

	internal static string NonStaticConstructorRequired => "The constructor should not be static";

	internal static string NonAbstractConstructorRequired => "Can't compile a NewExpression with a constructor declared on an abstract class";

	internal static string ExpressionMustBeReadable => "Expression must be readable";

	internal static string EnumerationIsDone => "Enumeration has either not started or has already finished.";

	internal static string InvalidArgumentValue => "Invalid argument value";

	internal static string NonEmptyCollectionRequired => "Non-empty collection required";

	internal static string IncorrectNumberOfLambdaArguments => "Incorrect number of arguments supplied for lambda invocation";

	internal static string IncorrectNumberOfConstructorArguments => "Incorrect number of arguments for constructor";

	internal static string VariableMustNotBeByRef(object p0, object p1)
	{
		return SR.Format("Variable '{0}' uses unsupported type '{1}'. Reference types are not supported for variables.", p0, p1);
	}

	internal static string AmbiguousMatchInExpandoObject(object p0)
	{
		return SR.Format("More than one key matching '{0}' was found in the ExpandoObject.", p0);
	}

	internal static string SameKeyExistsInExpando(object p0)
	{
		return SR.Format("An element with the same key '{0}' already exists in the ExpandoObject.", p0);
	}

	internal static string KeyDoesNotExistInExpando(object p0)
	{
		return SR.Format("The specified key '{0}' does not exist in the ExpandoObject.", p0);
	}

	internal static string InvalidMetaObjectCreated(object p0)
	{
		return SR.Format("An IDynamicMetaObjectProvider {0} created an invalid DynamicMetaObject instance.", p0);
	}

	internal static string BinderNotCompatibleWithCallSite(object p0, object p1, object p2)
	{
		return SR.Format("The result type '{0}' of the binder '{1}' is not compatible with the result type '{2}' expected by the call site.", p0, p1, p2);
	}

	internal static string DynamicBindingNeedsRestrictions(object p0, object p1)
	{
		return SR.Format("The result of the dynamic binding produced by the object with type '{0}' for the binder '{1}' needs at least one restriction.", p0, p1);
	}

	internal static string DynamicObjectResultNotAssignable(object p0, object p1, object p2, object p3)
	{
		return SR.Format("The result type '{0}' of the dynamic binding produced by the object with type '{1}' for the binder '{2}' is not compatible with the result type '{3}' expected by the call site.", p0, p1, p2, p3);
	}

	internal static string DynamicBinderResultNotAssignable(object p0, object p1, object p2)
	{
		return SR.Format("The result type '{0}' of the dynamic binding produced by binder '{1}' is not compatible with the result type '{2}' expected by the call site.", p0, p1, p2);
	}

	internal static string DuplicateVariable(object p0)
	{
		return SR.Format("Found duplicate parameter '{0}'. Each ParameterExpression in the list must be a unique object.", p0);
	}

	internal static string TypeParameterIsNotDelegate(object p0)
	{
		return SR.Format("Type parameter is {0}. Expected a delegate.", p0);
	}

	internal static string ExtensionNodeMustOverrideProperty(object p0)
	{
		return SR.Format("Extension node must override the property {0}.", p0);
	}

	internal static string UserDefinedOperatorMustBeStatic(object p0)
	{
		return SR.Format("User-defined operator method '{0}' must be static.", p0);
	}

	internal static string UserDefinedOperatorMustNotBeVoid(object p0)
	{
		return SR.Format("User-defined operator method '{0}' must not be void.", p0);
	}

	internal static string CoercionOperatorNotDefined(object p0, object p1)
	{
		return SR.Format("No coercion operator is defined between types '{0}' and '{1}'.", p0, p1);
	}

	internal static string UnaryOperatorNotDefined(object p0, object p1)
	{
		return SR.Format("The unary operator {0} is not defined for the type '{1}'.", p0, p1);
	}

	internal static string BinaryOperatorNotDefined(object p0, object p1, object p2)
	{
		return SR.Format("The binary operator {0} is not defined for the types '{1}' and '{2}'.", p0, p1, p2);
	}

	internal static string ReferenceEqualityNotDefined(object p0, object p1)
	{
		return SR.Format("Reference equality is not defined for the types '{0}' and '{1}'.", p0, p1);
	}

	internal static string OperandTypesDoNotMatchParameters(object p0, object p1)
	{
		return SR.Format("The operands for operator '{0}' do not match the parameters of method '{1}'.", p0, p1);
	}

	internal static string OverloadOperatorTypeDoesNotMatchConversionType(object p0, object p1)
	{
		return SR.Format("The return type of overload method for operator '{0}' does not match the parameter type of conversion method '{1}'.", p0, p1);
	}

	internal static string EqualityMustReturnBoolean(object p0)
	{
		return SR.Format("The user-defined equality method '{0}' must return a boolean value.", p0);
	}

	internal static string CannotAutoInitializeValueTypeMemberThroughProperty(object p0)
	{
		return SR.Format("Cannot auto initialize members of value type through property '{0}', use assignment instead", p0);
	}

	internal static string IncorrectTypeForTypeAs(object p0)
	{
		return SR.Format("The type used in TypeAs Expression must be of reference or nullable type, {0} is neither", p0);
	}

	internal static string ExpressionTypeCannotInitializeArrayType(object p0, object p1)
	{
		return SR.Format("An expression of type '{0}' cannot be used to initialize an array of type '{1}'", p0, p1);
	}

	internal static string ArgumentTypeDoesNotMatchMember(object p0, object p1)
	{
		return SR.Format(" Argument type '{0}' does not match the corresponding member type '{1}'", p0, p1);
	}

	internal static string ArgumentMemberNotDeclOnType(object p0, object p1)
	{
		return SR.Format(" The member '{0}' is not declared on type '{1}' being created", p0, p1);
	}

	internal static string ExpressionTypeDoesNotMatchReturn(object p0, object p1)
	{
		return SR.Format("Expression of type '{0}' cannot be used for return type '{1}'", p0, p1);
	}

	internal static string ExpressionTypeDoesNotMatchAssignment(object p0, object p1)
	{
		return SR.Format("Expression of type '{0}' cannot be used for assignment to type '{1}'", p0, p1);
	}

	internal static string ExpressionTypeDoesNotMatchLabel(object p0, object p1)
	{
		return SR.Format("Expression of type '{0}' cannot be used for label of type '{1}'", p0, p1);
	}

	internal static string ExpressionTypeNotInvocable(object p0)
	{
		return SR.Format("Expression of type '{0}' cannot be invoked", p0);
	}

	internal static string FieldNotDefinedForType(object p0, object p1)
	{
		return SR.Format("Field '{0}' is not defined for type '{1}'", p0, p1);
	}

	internal static string InstanceFieldNotDefinedForType(object p0, object p1)
	{
		return SR.Format("Instance field '{0}' is not defined for type '{1}'", p0, p1);
	}

	internal static string FieldInfoNotDefinedForType(object p0, object p1, object p2)
	{
		return SR.Format("Field '{0}.{1}' is not defined for type '{2}'", p0, p1, p2);
	}

	internal static string MemberNotFieldOrProperty(object p0)
	{
		return SR.Format("Member '{0}' not field or property", p0);
	}

	internal static string MethodContainsGenericParameters(object p0)
	{
		return SR.Format("Method {0} contains generic parameters", p0);
	}

	internal static string MethodIsGeneric(object p0)
	{
		return SR.Format("Method {0} is a generic method definition", p0);
	}

	internal static string MethodNotPropertyAccessor(object p0, object p1)
	{
		return SR.Format("The method '{0}.{1}' is not a property accessor", p0, p1);
	}

	internal static string PropertyDoesNotHaveGetter(object p0)
	{
		return SR.Format("The property '{0}' has no 'get' accessor", p0);
	}

	internal static string PropertyDoesNotHaveSetter(object p0)
	{
		return SR.Format("The property '{0}' has no 'set' accessor", p0);
	}

	internal static string PropertyDoesNotHaveAccessor(object p0)
	{
		return SR.Format("The property '{0}' has no 'get' or 'set' accessors", p0);
	}

	internal static string NotAMemberOfType(object p0, object p1)
	{
		return SR.Format("'{0}' is not a member of type '{1}'", p0, p1);
	}

	internal static string NotAMemberOfAnyType(object p0)
	{
		return SR.Format("'{0}' is not a member of any type", p0);
	}

	internal static string ParameterExpressionNotValidAsDelegate(object p0, object p1)
	{
		return SR.Format("ParameterExpression of type '{0}' cannot be used for delegate parameter of type '{1}'", p0, p1);
	}

	internal static string PropertyNotDefinedForType(object p0, object p1)
	{
		return SR.Format("Property '{0}' is not defined for type '{1}'", p0, p1);
	}

	internal static string InstancePropertyNotDefinedForType(object p0, object p1)
	{
		return SR.Format("Instance property '{0}' is not defined for type '{1}'", p0, p1);
	}

	internal static string InstancePropertyWithoutParameterNotDefinedForType(object p0, object p1)
	{
		return SR.Format("Instance property '{0}' that takes no argument is not defined for type '{1}'", p0, p1);
	}

	internal static string InstancePropertyWithSpecifiedParametersNotDefinedForType(object p0, object p1, object p2)
	{
		return SR.Format("Instance property '{0}{1}' is not defined for type '{2}'", p0, p1, p2);
	}

	internal static string InstanceAndMethodTypeMismatch(object p0, object p1, object p2)
	{
		return SR.Format("Method '{0}' declared on type '{1}' cannot be called with instance of type '{2}'", p0, p1, p2);
	}

	internal static string TypeMissingDefaultConstructor(object p0)
	{
		return SR.Format("Type '{0}' does not have a default constructor", p0);
	}

	internal static string ElementInitializerMethodNoRefOutParam(object p0, object p1)
	{
		return SR.Format("Parameter '{0}' of element initializer method '{1}' must not be a pass by reference parameter", p0, p1);
	}

	internal static string TypeNotIEnumerable(object p0)
	{
		return SR.Format("Type '{0}' is not IEnumerable", p0);
	}

	internal static string UnhandledBinary(object p0)
	{
		return SR.Format("Unhandled binary: {0}", p0);
	}

	internal static string UnhandledBindingType(object p0)
	{
		return SR.Format("Unhandled Binding Type: {0}", p0);
	}

	internal static string UnhandledUnary(object p0)
	{
		return SR.Format("Unhandled unary: {0}", p0);
	}

	internal static string UserDefinedOpMustHaveConsistentTypes(object p0, object p1)
	{
		return SR.Format("The user-defined operator method '{1}' for operator '{0}' must have identical parameter and return types.", p0, p1);
	}

	internal static string UserDefinedOpMustHaveValidReturnType(object p0, object p1)
	{
		return SR.Format("The user-defined operator method '{1}' for operator '{0}' must return the same type as its parameter or a derived type.", p0, p1);
	}

	internal static string LogicalOperatorMustHaveBooleanOperators(object p0, object p1)
	{
		return SR.Format("The user-defined operator method '{1}' for operator '{0}' must have associated boolean True and False operators.", p0, p1);
	}

	internal static string MethodWithArgsDoesNotExistOnType(object p0, object p1)
	{
		return SR.Format("No method '{0}' on type '{1}' is compatible with the supplied arguments.", p0, p1);
	}

	internal static string GenericMethodWithArgsDoesNotExistOnType(object p0, object p1)
	{
		return SR.Format("No generic method '{0}' on type '{1}' is compatible with the supplied type arguments and arguments. No type arguments should be provided if the method is non-generic. ", p0, p1);
	}

	internal static string MethodWithMoreThanOneMatch(object p0, object p1)
	{
		return SR.Format("More than one method '{0}' on type '{1}' is compatible with the supplied arguments.", p0, p1);
	}

	internal static string PropertyWithMoreThanOneMatch(object p0, object p1)
	{
		return SR.Format("More than one property '{0}' on type '{1}' is compatible with the supplied arguments.", p0, p1);
	}

	internal static string OutOfRange(object p0, object p1)
	{
		return SR.Format("{0} must be greater than or equal to {1}", p0, p1);
	}

	internal static string LabelTargetAlreadyDefined(object p0)
	{
		return SR.Format("Cannot redefine label '{0}' in an inner block.", p0);
	}

	internal static string LabelTargetUndefined(object p0)
	{
		return SR.Format("Cannot jump to undefined label '{0}'.", p0);
	}

	internal static string AmbiguousJump(object p0)
	{
		return SR.Format("Cannot jump to ambiguous label '{0}'.", p0);
	}

	internal static string NonLocalJumpWithValue(object p0)
	{
		return SR.Format("Cannot jump to non-local label '{0}' with a value. Only jumps to labels defined in outer blocks can pass values.", p0);
	}

	internal static string InvalidLvalue(object p0)
	{
		return SR.Format("Invalid lvalue for assignment: {0}.", p0);
	}

	internal static string MustRewriteToSameNode(object p0, object p1, object p2)
	{
		return SR.Format("When called from '{0}', rewriting a node of type '{1}' must return a non-null value of the same type. Alternatively, override '{2}' and change it to not visit children of this type.", p0, p1, p2);
	}

	internal static string MustRewriteChildToSameType(object p0, object p1, object p2)
	{
		return SR.Format("Rewriting child expression from type '{0}' to type '{1}' is not allowed, because it would change the meaning of the operation. If this is intentional, override '{2}' and change it to allow this rewrite.", p0, p1, p2);
	}

	internal static string MustRewriteWithoutMethod(object p0, object p1)
	{
		return SR.Format("Rewritten expression calls operator method '{0}', but the original node had no operator method. If this is intentional, override '{1}' and change it to allow this rewrite.", p0, p1);
	}

	internal static string TestValueTypeDoesNotMatchComparisonMethodParameter(object p0, object p1)
	{
		return SR.Format("Test value of type '{0}' cannot be used for the comparison method parameter of type '{1}'", p0, p1);
	}

	internal static string SwitchValueTypeDoesNotMatchComparisonMethodParameter(object p0, object p1)
	{
		return SR.Format("Switch value of type '{0}' cannot be used for the comparison method parameter of type '{1}'", p0, p1);
	}

	internal static string ExpressionTypeDoesNotMatchConstructorParameter(object p0, object p1)
	{
		return SR.Format("Expression of type '{0}' cannot be used for constructor parameter of type '{1}'", p0, p1);
	}

	internal static string TypeContainsGenericParameters(object p0)
	{
		return SR.Format("Type {0} contains generic parameters", p0);
	}

	internal static string TypeIsGeneric(object p0)
	{
		return SR.Format("Type {0} is a generic type definition", p0);
	}

	internal static string InvalidNullValue(object p0)
	{
		return SR.Format("The value null is not of type '{0}' and cannot be used in this collection.", p0);
	}

	internal static string InvalidObjectType(object p0, object p1)
	{
		return SR.Format("The value '{0}' is not of type '{1}' and cannot be used in this collection.", p0, p1);
	}

	internal static string ExpressionTypeDoesNotMatchMethodParameter(object p0, object p1, object p2)
	{
		return SR.Format("Expression of type '{0}' cannot be used for parameter of type '{1}' of method '{2}'", p0, p1, p2);
	}

	internal static string ExpressionTypeDoesNotMatchParameter(object p0, object p1)
	{
		return SR.Format("Expression of type '{0}' cannot be used for parameter of type '{1}'", p0, p1);
	}

	internal static string IncorrectNumberOfMethodCallArguments(object p0)
	{
		return SR.Format("Incorrect number of arguments supplied for call to method '{0}'", p0);
	}
}
