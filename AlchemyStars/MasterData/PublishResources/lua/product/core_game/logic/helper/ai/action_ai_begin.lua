LuaS �

xV           (w@�@C:/depot_matchsrpg/matchsrpg/b/170/client/Assets/../PublishResources/lua/product/core_game/logic/helper/ai/action_ai_begin.lua             @ A@  $@ �@ A�  � A $@��@  ���@ l   
@���@ l@  
@ �& �    requireai_node_new_classActionAiBegin
AINewNodeConstructor	OnUpdate        	          
@@�& �    m_bStartLogic            
         self               P    t   G @ L@� d� ��� �� ��@ �  FAA G����d� A�   ��@ �� �AA ǁ�  � ��A �  �A B AB ��̂� � �B C"  @�!@�� �� @�]A���C DG@ $� "   �A� ���C ]�� 	�F�C G���� � d�  b   ��� ��� ] ��@ �E�� �  ���CEF�E G��䃀�  @ �A ���C� � �  @ �A� @�� @�]A��   ����
���A� � ��� ���� FH GB��A�́H @�� �A ��H @�� �A �G �  � ��I �A�� � ��I ǁ�� & � '   m_entityOwnAIGetTargetPosGetSelfPos, 自己坐标GameHelperMakePosString，目标坐标       GetMobilityValidBattleConstUseObsoleteAI        %AI逻辑<禁止进入>, 行动力 = 
AINewNodeIsEntityDead, 自己挂了GetTargetEntity, 目标挂了BuffComponentHasFlag
BuffFlags	SkipTurn2AI逻辑<禁止进入>: Monster is stun 被击晕IsAIRoundEndAI逻辑<回合已经结束>%AI逻辑<允许进入>, 行动力 = m_bStartLogicCanMove SetMoveStateAIMoveStateMoveEnd	PrintLogPrintDebugLogAINewNodeStatusSuccessFailure         t                                                                                                                           $   $   $   $   %   %   &   &   &   &   &   *   *   *   *   *   +   +   ,   ,   ,   ,   ,   1   1   1   2   2   3   3   3   3   4   4   5   5   :   :   ;   ;   <   <   @   @   @   A   A      D   E   E   E   E   F   F   F   F   I   I   I   I   J   J   J   J   K   K   K   L   L   L   L   N   N   N   P      self    t   aiComponent   t   
posTarget   t   posSelf   t   stLogPosition   t   stBeginReason   t   bEnableStart   t   (for index)   X   (for limit)   X   (for step)   X   i   W   nMobilityTotal   W   
bMineDead,   W   bPlayerDead8   W   	buffCmptB   W   isStunH   L   isRoundEndN   W      _ENV                              	      	      P      P          _ENV