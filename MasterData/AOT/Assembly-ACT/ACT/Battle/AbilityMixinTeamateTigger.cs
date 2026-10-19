using System;
using ACT.Battle.Configs;
using ACT.Event;
using ACT.MultiPlayer;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinTeamateTigger : BaseAbilityMixin
{
	private ConfigMixinTeamateTrigger config;

	private Entity last;

	private Entity now;

	public AbilityMixinTeamateTigger(ConfigMixinTeamateTrigger _config, Ability ab, byte index)
		: base(ab, index)
	{
		config = _config;
	}

	internal override void RebindForPool(ConfigMixin configMixin, Ability ab, byte newIndex)
	{
		base.RebindForPool(configMixin, ab, newIndex);
		config = (ConfigMixinTeamateTrigger)configMixin;
		last = default;
		now = default;
	}

	internal override void ResetForPool()
	{
		config = null;
		last = default;
		now = default;
		base.ResetForPool();
	}

	private void callback(BaseEventContent obj)
	{
		if (obj is BattleCharacterChangeEvt battleCharacterChangeEvt)
		{
			last = battleCharacterChangeEvt.lastEb;
			now = battleCharacterChangeEvt.newEb;
		}
		LastEntityRemoveListener(last);
		MainEntityAddListener(now);
	}

	internal override void OnAdd()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, callback);
		MainEntityAddListener(now = MPPlayer.local.battleEntity);
	}

	internal override void ListenEvt(BaseEvt evt)
	{
		if (evt is EvtBattleChange)
		{
			ListenEvtType listen = ListenEvtType.BattleChange;
			ApplyActions(listen, evt);
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError("不该跑到这里");
		}
	}

	internal override void OnEvt(BaseEvt evt)
	{
		ListenEvtType listen;
		if (!(evt is EvtAttack))
		{
			if (!(evt is EvtAttacked))
			{
				if (!(evt is EvtDealDamage))
				{
					if (!(evt is EvtDamaged))
					{
						if (!(evt is EvtModifyDamage))
						{
							if (!(evt is EvtAttackeeModifyDamage))
							{
								if (!(evt is EvtAttackeeModifyTenacitied))
								{
									if (!(evt is EvtBattleChange))
									{
										if (!(evt is EvtEnterWeak))
										{
											if (!(evt is EvtCriticalDamage))
											{
												if (!(evt is EvtTenacitiedRecoverMax))
												{
													if (!(evt is EvtTenacitiedDamaged))
													{
														if (!(evt is EvtAddAbilityAdd))
														{
															if (!(evt is EvtPostureDamage))
															{
																if (!(evt is EvtSetSwitchPos))
																{
																	if (!(evt is EvtPerfectDodge))
																	{
																		if (!(evt is EvtUltra))
																		{
																			if (!(evt is EvtStateChange))
																			{
																				if (!(evt is EvtOpenBox))
																				{
																					if (!(evt is EvtAddAbilityAddTo))
																					{
																						if (!(evt is EvtDynamicValueChange))
																						{
																							if (!(evt is EvtAirAttackCountChange))
																							{
																								if (!(evt is EvtHitWall))
																								{
																									if (!(evt is EvtKillEntity))
																									{
																										if (!(evt is EvtDodge))
																										{
																											if (!(evt is EvtDummyCreate))
																											{
																												if (!(evt is EvtCreateBullet))
																												{
																													if (!(evt is EvtSkill))
																													{
																														if (!(evt is EvtLastCombo))
																														{
																															if (!(evt is EvtAfterSwitchSkill))
																															{
																																if (!(evt is EvtAirDodge))
																																{
																																	if (!(evt is EvtNormalAttack))
																																	{
																																		if (!(evt is EvtSacrificeHp))
																																		{
																																			if (!(evt is EvtSummonMonster))
																																			{
																																				if (!(evt is EvtSummonMonsterDie))
																																				{
																																					if (!(evt is EvtBulletDie))
																																					{
																																						if (!(evt is EvtBeforeSacrificeHp))
																																						{
																																							if (!(evt is EvtBeforeRemoveSummonMonster))
																																							{
																																								if (!(evt is EvtSetCanRemain))
																																								{
																																									if (LuminApplication.LogEnabled)
																																									{
																																										Debug.LogError("不该跑到这里");
																																									}
																																									return;
																																								}
																																								listen = ListenEvtType.WhenCheckRemain;
																																							}
																																							else
																																							{
																																								listen = ListenEvtType.BeforeRemoveSummonMonster;
																																							}
																																						}
																																						else
																																						{
																																							listen = ListenEvtType.BeforeSacrificeHp;
																																						}
																																					}
																																					else
																																					{
																																						listen = ListenEvtType.OnBulletDie;
																																					}
																																				}
																																				else
																																				{
																																					listen = ListenEvtType.SummonMonsterDie;
																																				}
																																			}
																																			else
																																			{
																																				listen = ListenEvtType.SummonMonster;
																																			}
																																		}
																																		else
																																		{
																																			listen = ListenEvtType.OnSacrificeHp;
																																		}
																																	}
																																	else
																																	{
																																		listen = ListenEvtType.OnNormalAttack;
																																	}
																																}
																																else
																																{
																																	listen = ListenEvtType.OnAirDodge;
																																}
																															}
																															else
																															{
																																listen = ListenEvtType.AfterSwitchSkill;
																															}
																														}
																														else
																														{
																															listen = ListenEvtType.OnLastCombo;
																														}
																													}
																													else
																													{
																														listen = ListenEvtType.OnSkill;
																													}
																												}
																												else
																												{
																													listen = ListenEvtType.OnBulletCreate;
																												}
																											}
																											else
																											{
																												listen = ListenEvtType.OnDummyCreate;
																											}
																										}
																										else
																										{
																											listen = ListenEvtType.OnDodge;
																										}
																									}
																									else
																									{
																										listen = ListenEvtType.AfterMeKillEntity;
																									}
																								}
																								else
																								{
																									listen = ListenEvtType.WhenHitWall;
																								}
																							}
																							else
																							{
																								listen = ListenEvtType.WhenMeAirAttackCountChange;
																							}
																						}
																						else
																						{
																							listen = ListenEvtType.WhenMeDynamicValueChange;
																						}
																					}
																					else
																					{
																						listen = ListenEvtType.WhenMeAddAbilityTo;
																					}
																				}
																				else
																				{
																					listen = ListenEvtType.WhenMeOpenBox;
																				}
																			}
																			else
																			{
																				listen = ListenEvtType.WhenMeStateChange;
																			}
																		}
																		else
																		{
																			listen = ListenEvtType.WhenMeULTRA;
																		}
																	}
																	else
																	{
																		listen = ListenEvtType.WhenMePerfectDodge;
																	}
																}
																else
																{
																	listen = ListenEvtType.WhenSwitchSkill;
																}
															}
															else
															{
																listen = ListenEvtType.WhenMePostureDamaged;
															}
														}
														else
														{
															listen = ListenEvtType.WhenMeAddAbility;
														}
													}
													else
													{
														listen = ListenEvtType.AfterMeTenacitiedDamaged;
													}
												}
												else
												{
													listen = ListenEvtType.WhenMeTenacitiedRecoverMax;
												}
											}
											else
											{
												listen = ListenEvtType.WhenMeCriticalDamage;
											}
										}
										else
										{
											listen = ListenEvtType.WhenMeEnterWeak;
										}
									}
									else
									{
										listen = ListenEvtType.BattleChange;
									}
								}
								else
								{
									listen = ListenEvtType.WhenMeModifyTenacitied;
								}
							}
							else
							{
								listen = ListenEvtType.WhenMeModifyDamaged;
							}
						}
						else
						{
							listen = ListenEvtType.WhenMeModifyDamage;
						}
					}
					else
					{
						listen = ListenEvtType.AfterMeDamaged;
					}
				}
				else
				{
					listen = ListenEvtType.AfterMeDealDamage;
				}
			}
			else
			{
				listen = ListenEvtType.AfterMeAttacked;
			}
		}
		else
		{
			listen = ListenEvtType.AfterMeAttack;
		}
		ApplyActions(listen, evt);
	}

	internal override void FixedUpdate()
	{
		base.FixedUpdate();
	}

	internal override void OnRemove()
	{
		LastEntityRemoveListener(now);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, callback);
	}

	internal override void OnSilentRemove()
	{
		LastEntityRemoveListener(now);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, callback);
	}

	private void ApplyActions(ListenEvtType listen, BaseEvt evt)
	{
		try
		{
			for (int i = 0; i < config.configs.Length; i++)
			{
				ListenEvtItem listenEvtItem = config.configs[i];
				if (!listenEvtItem.MatchType(listen, evt))
				{
					continue;
				}
				switch (config.target)
				{
				case ActionTargetType.Self:
					DoActions(owner, evt, listenEvtItem.actions);
					break;
				case ActionTargetType.Team:
				{
					for (int j = 0; j < 3; j++)
					{
						Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(j);
						DoActions(teamCharacter, evt, listenEvtItem.actions);
					}
					break;
				}
				}
			}
		}
		catch (Exception arg)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"*********策划处理下：监听技能报错了,ability:{ability.config.name}, ex:{arg}");
			}
		}
	}

	private void MainEntityAddListener(Entity listener)
	{
		CompAbility compAbility = listener.GetCompAbility();
		for (int i = 0; i < config.configs.Length; i++)
		{
			switch (config.configs[i].listenEvtType)
			{
			case ListenEvtType.AfterMeAttack:
				compAbility.AddListener(typeof(EvtAttack), this);
				break;
			case ListenEvtType.AfterMeAttacked:
				compAbility.AddListener(typeof(EvtAttacked), this);
				break;
			case ListenEvtType.AfterMeDealDamage:
				compAbility.AddListener(typeof(EvtDealDamage), this);
				break;
			case ListenEvtType.AfterMeDamaged:
				compAbility.AddListener(typeof(EvtDamaged), this);
				break;
			case ListenEvtType.WhenMeModifyDamage:
				compAbility.AddListener(typeof(EvtModifyDamage), this);
				break;
			case ListenEvtType.WhenMeModifyDamaged:
				compAbility.AddListener(typeof(EvtAttackeeModifyDamage), this);
				break;
			case ListenEvtType.WhenMeModifyTenacitied:
				compAbility.AddListener(typeof(EvtAttackeeModifyTenacitied), this);
				break;
			case ListenEvtType.BattleChange:
				GameManager.abilitySystem.AddListener(typeof(EvtBattleChange), this);
				break;
			case ListenEvtType.WhenMeEnterWeak:
				compAbility.AddListener(typeof(EvtEnterWeak), this);
				break;
			case ListenEvtType.WhenMeCriticalDamage:
				compAbility.AddListener(typeof(EvtCriticalDamage), this);
				break;
			case ListenEvtType.WhenMeTenacitiedRecoverMax:
				compAbility.AddListener(typeof(EvtTenacitiedRecoverMax), this);
				break;
			case ListenEvtType.AfterMeTenacitiedDamaged:
				compAbility.AddListener(typeof(EvtTenacitiedDamaged), this);
				break;
			case ListenEvtType.WhenMeAddAbility:
				compAbility.AddListener(typeof(EvtAddAbilityAdd), this);
				break;
			case ListenEvtType.WhenMePostureDamaged:
				compAbility.AddListener(typeof(EvtPostureDamage), this);
				break;
			case ListenEvtType.WhenSwitchSkill:
				compAbility.AddListener(typeof(EvtSetSwitchPos), this);
				break;
			case ListenEvtType.WhenMePerfectDodge:
				compAbility.AddListener(typeof(EvtPerfectDodge), this);
				break;
			case ListenEvtType.WhenMeULTRA:
				compAbility.AddListener(typeof(EvtUltra), this);
				break;
			case ListenEvtType.WhenMeStateChange:
				compAbility.AddListener(typeof(EvtStateChange), this);
				break;
			case ListenEvtType.WhenMeOpenBox:
				compAbility.AddListener(typeof(EvtOpenBox), this);
				break;
			case ListenEvtType.WhenMeAddAbilityTo:
				compAbility.AddListener(typeof(EvtAddAbilityAddTo), this);
				break;
			case ListenEvtType.WhenMeDynamicValueChange:
				compAbility.AddListener(typeof(EvtDynamicValueChange), this);
				break;
			case ListenEvtType.WhenMeAirAttackCountChange:
				compAbility.AddListener(typeof(EvtAirAttackCountChange), this);
				break;
			case ListenEvtType.WhenHitWall:
				compAbility.AddListener(typeof(EvtHitWall), this);
				break;
			case ListenEvtType.AfterMeKillEntity:
			case ListenEvtType.AfterMeKillBullet:
				compAbility.AddListener(typeof(EvtKillEntity), this);
				break;
			case ListenEvtType.OnDodge:
				compAbility.AddListener(typeof(EvtDodge), this);
				break;
			case ListenEvtType.OnDummyCreate:
				compAbility.AddListener(typeof(EvtDummyCreate), this);
				break;
			case ListenEvtType.OnBulletCreate:
				compAbility.AddListener(typeof(EvtCreateBullet), this);
				break;
			case ListenEvtType.OnSkill:
				compAbility.AddListener(typeof(EvtSkill), this);
				break;
			case ListenEvtType.OnLastCombo:
				compAbility.AddListener(typeof(EvtLastCombo), this);
				break;
			case ListenEvtType.AfterSwitchSkill:
				compAbility.AddListener(typeof(EvtAfterSwitchSkill), this);
				break;
			case ListenEvtType.OnAirDodge:
				compAbility.AddListener(typeof(EvtAirDodge), this);
				break;
			case ListenEvtType.OnNormalAttack:
				compAbility.AddListener(typeof(EvtNormalAttack), this);
				break;
			case ListenEvtType.OnSacrificeHp:
				compAbility.AddListener(typeof(EvtSacrificeHp), this);
				break;
			case ListenEvtType.SummonMonster:
				compAbility.AddListener(typeof(EvtSummonMonster), this);
				break;
			case ListenEvtType.SummonMonsterDie:
				compAbility.AddListener(typeof(EvtSummonMonsterDie), this);
				break;
			case ListenEvtType.OnBulletDie:
				compAbility.AddListener(typeof(EvtBulletDie), this);
				break;
			case ListenEvtType.BeforeSacrificeHp:
				compAbility.AddListener(typeof(EvtBeforeSacrificeHp), this);
				break;
			case ListenEvtType.BeforeRemoveSummonMonster:
				compAbility.AddListener(typeof(EvtBeforeRemoveSummonMonster), this);
				break;
			case ListenEvtType.WhenMeBreakPoint:
				compAbility.AddListener(typeof(EvtBreakPoint), this);
				break;
			case ListenEvtType.WhenCheckRemain:
				compAbility.AddListener(typeof(EvtSetCanRemain), this);
				break;
			}
		}
	}

	private void LastEntityRemoveListener(Entity listener)
	{
		CompAbility compAbility = listener.GetCompAbility();
		for (int i = 0; i < config.configs.Length; i++)
		{
			switch (config.configs[i].listenEvtType)
			{
			case ListenEvtType.AfterMeAttack:
				compAbility.RemoveListener(typeof(EvtAttack), this);
				break;
			case ListenEvtType.AfterMeAttacked:
				compAbility.RemoveListener(typeof(EvtAttacked), this);
				break;
			case ListenEvtType.AfterMeDealDamage:
				compAbility.RemoveListener(typeof(EvtDealDamage), this);
				break;
			case ListenEvtType.AfterMeDamaged:
				compAbility.RemoveListener(typeof(EvtDamaged), this);
				break;
			case ListenEvtType.WhenMeModifyDamage:
				compAbility.RemoveListener(typeof(EvtModifyDamage), this);
				break;
			case ListenEvtType.WhenMeModifyDamaged:
				compAbility.RemoveListener(typeof(EvtAttackeeModifyDamage), this);
				break;
			case ListenEvtType.WhenMeModifyTenacitied:
				compAbility.RemoveListener(typeof(EvtAttackeeModifyTenacitied), this);
				break;
			case ListenEvtType.BattleChange:
				GameManager.abilitySystem.RemoveListener(typeof(EvtBattleChange), this);
				break;
			case ListenEvtType.WhenMeEnterWeak:
				compAbility.RemoveListener(typeof(EvtEnterWeak), this);
				break;
			case ListenEvtType.WhenMeCriticalDamage:
				compAbility.RemoveListener(typeof(EvtCriticalDamage), this);
				break;
			case ListenEvtType.WhenMeTenacitiedRecoverMax:
				compAbility.RemoveListener(typeof(EvtTenacitiedRecoverMax), this);
				break;
			case ListenEvtType.AfterMeTenacitiedDamaged:
				compAbility.RemoveListener(typeof(EvtTenacitiedDamaged), this);
				break;
			case ListenEvtType.WhenMeAddAbility:
				compAbility.RemoveListener(typeof(EvtAddAbilityAdd), this);
				break;
			case ListenEvtType.WhenMePostureDamaged:
				compAbility.RemoveListener(typeof(EvtPostureDamage), this);
				break;
			case ListenEvtType.WhenSwitchSkill:
				compAbility.RemoveListener(typeof(EvtSetSwitchPos), this);
				break;
			case ListenEvtType.WhenMePerfectDodge:
				compAbility.RemoveListener(typeof(EvtPerfectDodge), this);
				break;
			case ListenEvtType.WhenMeULTRA:
				compAbility.RemoveListener(typeof(EvtUltra), this);
				break;
			case ListenEvtType.WhenMeStateChange:
				compAbility.RemoveListener(typeof(EvtStateChange), this);
				break;
			case ListenEvtType.WhenMeOpenBox:
				compAbility.RemoveListener(typeof(EvtOpenBox), this);
				break;
			case ListenEvtType.WhenMeAddAbilityTo:
				compAbility.RemoveListener(typeof(EvtAddAbilityAddTo), this);
				break;
			case ListenEvtType.WhenMeDynamicValueChange:
				compAbility.RemoveListener(typeof(EvtDynamicValueChange), this);
				break;
			case ListenEvtType.WhenMeAirAttackCountChange:
				compAbility.RemoveListener(typeof(EvtAirAttackCountChange), this);
				break;
			case ListenEvtType.WhenHitWall:
				compAbility.RemoveListener(typeof(EvtHitWall), this);
				break;
			case ListenEvtType.AfterMeKillEntity:
			case ListenEvtType.AfterMeKillBullet:
				compAbility.RemoveListener(typeof(EvtKillEntity), this);
				break;
			case ListenEvtType.OnDodge:
				compAbility.RemoveListener(typeof(EvtDodge), this);
				break;
			case ListenEvtType.OnDummyCreate:
				compAbility.RemoveListener(typeof(EvtDummyCreate), this);
				break;
			case ListenEvtType.OnBulletCreate:
				compAbility.RemoveListener(typeof(EvtCreateBullet), this);
				break;
			case ListenEvtType.OnSkill:
				compAbility.RemoveListener(typeof(EvtSkill), this);
				break;
			case ListenEvtType.OnLastCombo:
				compAbility.RemoveListener(typeof(EvtLastCombo), this);
				break;
			case ListenEvtType.AfterSwitchSkill:
				compAbility.RemoveListener(typeof(EvtAfterSwitchSkill), this);
				break;
			case ListenEvtType.OnAirDodge:
				compAbility.RemoveListener(typeof(EvtAirDodge), this);
				break;
			case ListenEvtType.OnNormalAttack:
				compAbility.RemoveListener(typeof(EvtNormalAttack), this);
				break;
			case ListenEvtType.OnSacrificeHp:
				compAbility.RemoveListener(typeof(EvtSacrificeHp), this);
				break;
			case ListenEvtType.SummonMonster:
				compAbility.RemoveListener(typeof(EvtSummonMonster), this);
				break;
			case ListenEvtType.SummonMonsterDie:
				compAbility.RemoveListener(typeof(EvtSummonMonsterDie), this);
				break;
			case ListenEvtType.OnBulletDie:
				compAbility.RemoveListener(typeof(EvtBulletDie), this);
				break;
			case ListenEvtType.BeforeSacrificeHp:
				compAbility.RemoveListener(typeof(EvtBeforeSacrificeHp), this);
				break;
			case ListenEvtType.BeforeRemoveSummonMonster:
				compAbility.RemoveListener(typeof(EvtBeforeRemoveSummonMonster), this);
				break;
			case ListenEvtType.WhenMeBreakPoint:
				compAbility.RemoveListener(typeof(EvtBreakPoint), this);
				break;
			case ListenEvtType.WhenCheckRemain:
				compAbility.RemoveListener(typeof(EvtSetCanRemain), this);
				break;
			}
		}
	}
}
