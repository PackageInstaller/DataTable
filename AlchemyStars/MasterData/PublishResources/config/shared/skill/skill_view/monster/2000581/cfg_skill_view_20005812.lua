LuaS �

xV           (w@�@E:/depot_matchsrpg/matchsrpg/b/150/client/Assets/../PublishResources/config/shared/skill/skill_view/monster/2000581/cfg_skill_view_20005812.lua         %   � 
@@�
�@�
@A�
�A�
@B�
�B�
@C�K  � ��@  A  A� �A  �� � K� �� kB� �@�� ��  A�  �� �A  � A� �� � �B� �@�k@ � � �      �  & �    ID       
ViewPhase       
PhaseType       
DelayType       DelayFromPhase       DelayMS       PhaseParam               ��       DataSelectDamage,damageIndex = 1; Wait,waitTime=300; PlayCasterMaterialAnim,animName=eff_2900681_skill02; PlayAudio,audioID = 6123,audioType=1; Wait,waitTime=550; PlayCasterBindEffect,effectID=3126; PlayCasterVisible,visible=0; PlayCasterHUDVisible,visible=0; PlayCasterControlGridDown,enable=0; PlayCasterControlOutLine,enable=0; Wait,waitTime=200; Wait,waitTime=300; PlaySummonTrap,trapID=PARAM.trapID; DataSelectResult,effectType=120,index=1; PlayDestroyMonster; � Wait,waitTime=1050; DataSelectDamage,damageIndex = 1; PlayCommonBeHit,hitAnimName=Hit,hitEffectID=0,turnToTarget=1,deathClear=0,label=doAgain; DataSelectNextDamage; Jump,condition=CheckDamageIndexValid,goto=doAgain;         %                                                                                                                     key   %   config    %      _ENV