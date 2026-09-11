return {
	Play939021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 939021001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play939021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.STblack == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_4_0.name = "STblack"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STblack = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.marker = "luntantiezi3"
				arg_1_1.actionList["1"] = arg_1_1.actionList["1"] or StoryInteractionRogueCardForumGame.New(arg_1_1, "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI")

				arg_1_1.actionList["1"]:SetData({
					hideOnEndGame = true,
					type = 1,
					postId = 102,
					enterClipName = "",
					completeShowStoryUI = true,
					isNeedInteraction = true,
					uiBtnName = "bgBtn_",
					enterHideStoryUI = true,
					completeClipName = "",
					enterController = {},
					completeController = {}
				})
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_0_ui_minigame_wuchang_story", "bgm_activity_5_0_ui_minigame_wuchang_story", "bgm_activity_5_0_ui_minigame_wuchang_story.awb")

				local var_4_13 = manager.audio:GetAudioName("bgm_activity_5_0_ui_minigame_wuchang_story", "bgm_activity_5_0_ui_minigame_wuchang_story")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play939021002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 939021002
		arg_6_1.duration_ = 7

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play939021003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			if arg_6_1.bgs_.ST15a == nil then
				local var_9_0 = Object.Instantiate(arg_6_1.paintGo_)

				var_9_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST15a")
				var_9_0.name = "ST15a"
				var_9_0.transform.parent = arg_6_1.stage_.transform
				var_9_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.bgs_.ST15a = var_9_0
			end

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= 0 + arg_9_0 then
				local var_9_1 = arg_6_1.bgs_.ST15a

				arg_6_1.bgs_.ST15a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_9_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_9_2 = var_9_1:GetComponent("SpriteRenderer")

				if var_9_2 and var_9_2.sprite then
					local var_9_3 = 2 * (var_9_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_9_1.transform.localScale = Vector3.New(var_9_3 / var_9_2.sprite.bounds.size.y < var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x and var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x or var_9_3 / var_9_2.sprite.bounds.size.y, var_9_3 / var_9_2.sprite.bounds.size.y < var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x and var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x or var_9_3 / var_9_2.sprite.bounds.size.y, 0)
				end

				for iter_9_0, iter_9_1 in pairs(arg_6_1.bgs_) do
					if iter_9_0 ~= "ST15a" then
						iter_9_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_9_4 = 2

			if 2 < arg_6_1.time_ and arg_6_1.time_ <= var_9_4 + arg_9_0 then
				arg_6_1.allBtn_.enabled = false
			end

			if arg_6_1.time_ >= var_9_4 + 0.3 and arg_6_1.time_ < var_9_4 + 0.3 + arg_9_0 then
				arg_6_1.allBtn_.enabled = true
			end

			local var_9_5 = 0

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_5 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = true

				arg_6_1:SetGaussion(false)
			end

			local var_9_6 = 2

			if var_9_5 <= arg_6_1.time_ and arg_6_1.time_ < var_9_5 + var_9_6 then
				local var_9_7 = Color.New(0, 0, 0)

				var_9_7.a = Mathf.Lerp(1, 0, (arg_6_1.time_ - var_9_5) / var_9_6)
				arg_6_1.mask_.color = var_9_7
			end

			if arg_6_1.time_ >= var_9_5 + var_9_6 and arg_6_1.time_ < var_9_5 + var_9_6 + arg_9_0 then
				local var_9_8 = Color.New(0, 0, 0)

				arg_6_1.mask_.enabled = false
				var_9_8.a = 0
				arg_6_1.mask_.color = var_9_8
			end

			local var_9_9 = "1284ui_story"

			if arg_6_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_9_10 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_6_1.stage_.transform)

				var_9_10.name = var_9_9
				var_9_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.actors_[var_9_9] = var_9_10

				local var_9_11 = var_9_10:GetComponentInChildren(typeof(CharacterEffect))

				var_9_11.enabled = true

				local var_9_12 = GameObjectTools.GetOrAddComponent(var_9_10, typeof(DynamicBoneHelper))

				if var_9_12 then
					var_9_12:EnableDynamicBone(false)
				end

				arg_6_1:ShowWeapon(var_9_11.transform, false)

				arg_6_1.var_[var_9_9 .. "Animator"] = var_9_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_6_1.var_[var_9_9 .. "Animator"].applyRootMotion = true
				arg_6_1.var_[var_9_9 .. "LipSync"] = var_9_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_9_13 = arg_6_1.actors_["1284ui_story"].transform

			if 1.83333333333333 < arg_6_1.time_ and arg_6_1.time_ <= 1.83333333333333 + arg_9_0 then
				arg_6_1.var_.moveOldPos1284ui_story = var_9_13.localPosition
			end

			local var_9_14 = 0.001

			if 1.83333333333333 <= arg_6_1.time_ and arg_6_1.time_ < 1.83333333333333 + var_9_14 then
				var_9_13.localPosition = Vector3.Lerp(arg_6_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_6_1.time_ - 1.83333333333333) / var_9_14)
				var_9_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_9_13.position).x, (manager.ui.mainCamera.transform.position - var_9_13.position).y, (manager.ui.mainCamera.transform.position - var_9_13.position).z)
				var_9_13.localEulerAngles.z = 0
				var_9_13.localEulerAngles.x = 0
				var_9_13.localEulerAngles = var_9_13.localEulerAngles
			end

			if arg_6_1.time_ >= 1.83333333333333 + var_9_14 and arg_6_1.time_ < 1.83333333333333 + var_9_14 + arg_9_0 then
				var_9_13.localPosition = Vector3.New(0, -0.985, -6.22)
				var_9_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_9_13.position).x, (manager.ui.mainCamera.transform.position - var_9_13.position).y, (manager.ui.mainCamera.transform.position - var_9_13.position).z)
				var_9_13.localEulerAngles.z = 0
				var_9_13.localEulerAngles.x = 0
				var_9_13.localEulerAngles = var_9_13.localEulerAngles
			end

			local var_9_15 = arg_6_1.actors_["1284ui_story"]

			if 1.83333333333333 < arg_6_1.time_ and arg_6_1.time_ <= 1.83333333333333 + arg_9_0 and not isNil(var_9_15) and arg_6_1.var_.characterEffect1284ui_story == nil then
				arg_6_1.var_.characterEffect1284ui_story = var_9_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_9_16 = 0.200000002980232

			if 1.83333333333333 <= arg_6_1.time_ and arg_6_1.time_ < 1.83333333333333 + var_9_16 and not isNil(var_9_15) then
				if arg_6_1.var_.characterEffect1284ui_story and not isNil(var_9_15) then
					arg_6_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_6_1.time_ >= 1.83333333333333 + var_9_16 and arg_6_1.time_ < 1.83333333333333 + var_9_16 + arg_9_0 and not isNil(var_9_15) and arg_6_1.var_.characterEffect1284ui_story then
				arg_6_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 1.83333333333333 < arg_6_1.time_ and arg_6_1.time_ <= 1.83333333333333 + arg_9_0 then
				arg_6_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			if 1.83333333333333 < arg_6_1.time_ and arg_6_1.time_ <= 1.83333333333333 + arg_9_0 then
				arg_6_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			if arg_6_1.frameCnt_ <= 1 then
				arg_6_1.dialog_:SetActive(false)
			end

			local var_9_18 = 2
			local var_9_19 = 0.75

			if 2 < arg_6_1.time_ and arg_6_1.time_ <= var_9_18 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				arg_6_1.dialog_:SetActive(true)

				arg_6_1.dialogCg_.alpha = 0

				local var_9_20 = LeanTween.value(arg_6_1.dialog_, 0, 1, 0.3)

				var_9_20:setOnUpdate(LuaHelper.FloatAction(function(arg_10_0)
					arg_6_1.dialogCg_.alpha = arg_10_0
				end))
				var_9_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_6_1.dialog_)
					var_9_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_6_1.duration_ = arg_6_1.duration_ + 0.3

				SetActive(arg_6_1.leftNameGo_, true)

				arg_6_1.leftNameTxt_.text = arg_6_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_1.leftNameTxt_.transform)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1.leftNameTxt_.text)
				SetActive(arg_6_1.iconTrs_.gameObject, false)
				arg_6_1.callingController_:SetSelectedState("normal")

				local var_9_21 = arg_6_1:FormatText(arg_6_1:GetWordFromCfg(939021002).content)

				arg_6_1.text_.text = var_9_21

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_23 = 30 <= 0 and var_9_19 or var_9_19 * (utf8.len(var_9_21) / 30)

				if (30 <= 0 and var_9_19 or var_9_19 * (utf8.len(var_9_21) / 30)) > 0 and var_9_19 < var_9_23 then
					arg_6_1.talkMaxDuration = var_9_23
					var_9_18 = var_9_18 + 0.3

					if var_9_23 + var_9_18 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_23 + var_9_18
					end
				end

				arg_6_1.text_.text = var_9_21
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)
				arg_6_1:RecordContent(arg_6_1.text_.text)
			end

			local var_9_24 = var_9_18 + 0.3
			local var_9_25 = math.max(var_9_19, arg_6_1.talkMaxDuration)

			if var_9_18 + 0.3 <= arg_6_1.time_ and arg_6_1.time_ < var_9_24 + var_9_25 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - var_9_24) / var_9_25

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= var_9_24 + var_9_25 and arg_6_1.time_ < var_9_24 + var_9_25 + arg_9_0 then
				arg_6_1.typewritter.percent = 1

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(true)
			end
		end

		arg_6_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_6_1:InitPlayNodeList()
	end,
	Play939021003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 939021003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play939021004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1284ui_story"]) and arg_12_1.var_.characterEffect1284ui_story == nil then
				arg_12_1.var_.characterEffect1284ui_story = arg_12_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1284ui_story"]) then
				if arg_12_1.var_.characterEffect1284ui_story and not isNil(arg_12_1.actors_["1284ui_story"]) then
					arg_12_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_0)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1284ui_story"]) and arg_12_1.var_.characterEffect1284ui_story then
				arg_12_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_15_1 = 0
			local var_15_2 = 1.175

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_3 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(939021003).content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 47 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 47)

				if (47 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 47)) > 0 and var_15_2 < var_15_5 then
					arg_12_1.talkMaxDuration = var_15_5

					if var_15_5 + var_15_1 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + var_15_1
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_6 = math.max(var_15_2, arg_12_1.talkMaxDuration)

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_6 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_1) / var_15_6

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_1 + var_15_6 and arg_12_1.time_ < var_15_1 + var_15_6 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play939021004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 939021004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play939021005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.45

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(939021004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 18 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 18)

				if (18 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 18)) > 0 and var_19_0 < var_19_3 then
					arg_16_1.talkMaxDuration = var_19_3

					if var_19_3 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_3 + 0
					end
				end

				arg_16_1.text_.text = var_19_1
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_4 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_4

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play939021005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 939021005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play939021006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1284ui_story = arg_20_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_23_0 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 then
				arg_20_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_0)
				arg_20_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1284ui_story"].transform.position).z)
				arg_20_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["1284ui_story"].transform.localEulerAngles = arg_20_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 then
				arg_20_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["1284ui_story"].transform.position).z)
				arg_20_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["1284ui_story"].transform.localEulerAngles = arg_20_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_23_1 = 0
			local var_23_2 = 1.55

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_3 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(939021005).content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 62 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 62)

				if (62 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 62)) > 0 and var_23_2 < var_23_5 then
					arg_20_1.talkMaxDuration = var_23_5

					if var_23_5 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + var_23_1
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_6 = math.max(var_23_2, arg_20_1.talkMaxDuration)

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_6 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_1) / var_23_6

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_1 + var_23_6 and arg_20_1.time_ < var_23_1 + var_23_6 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play939021006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 939021006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play939021007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_27_0 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_24_1.stage_.transform)

				var_27_0.name = "1054ui_story"
				var_27_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["1054ui_story"] = var_27_0

				local var_27_1 = var_27_0:GetComponentInChildren(typeof(CharacterEffect))

				var_27_1.enabled = true

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end

				arg_24_1:ShowWeapon(var_27_1.transform, false)

				arg_24_1.var_["1054ui_story" .. "Animator"] = var_27_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_24_1.var_["1054ui_story" .. "Animator"].applyRootMotion = true
				arg_24_1.var_["1054ui_story" .. "LipSync"] = var_27_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_27_3 = arg_24_1.actors_["1054ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1054ui_story = var_27_3.localPosition

				local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_3.gameObject, typeof(DynamicBoneHelper))

				if var_27_4 then
					var_27_4:EnableDynamicBone(false)
				end
			end

			local var_27_5 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_5 then
				var_27_3.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_24_1.time_ - 0) / var_27_5)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_5 and arg_24_1.time_ < 0 + var_27_5 + arg_27_0 then
				var_27_3.localPosition = Vector3.New(0, -0.985, -6)
				var_27_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_3.position).x, (manager.ui.mainCamera.transform.position - var_27_3.position).y, (manager.ui.mainCamera.transform.position - var_27_3.position).z)
				var_27_3.localEulerAngles.z = 0
				var_27_3.localEulerAngles.x = 0
				var_27_3.localEulerAngles = var_27_3.localEulerAngles

				local var_27_6 = GameObjectTools.GetOrAddComponent(var_27_3.gameObject, typeof(DynamicBoneHelper))

				if var_27_6 then
					var_27_6:EnableDynamicBone(true)
				end
			end

			local var_27_7 = arg_24_1.actors_["1054ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_7) and arg_24_1.var_.characterEffect1054ui_story == nil then
				arg_24_1.var_.characterEffect1054ui_story = var_27_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_8 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_8 and not isNil(var_27_7) then
				if arg_24_1.var_.characterEffect1054ui_story and not isNil(var_27_7) then
					arg_24_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_8 and arg_24_1.time_ < 0 + var_27_8 + arg_27_0 and not isNil(var_27_7) and arg_24_1.var_.characterEffect1054ui_story then
				arg_24_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_27_10 = 0
			local var_27_11 = 0.275

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_12 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(939021006).content)

				arg_24_1.text_.text = var_27_12

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_14 = 11 <= 0 and var_27_11 or var_27_11 * (utf8.len(var_27_12) / 11)

				if (11 <= 0 and var_27_11 or var_27_11 * (utf8.len(var_27_12) / 11)) > 0 and var_27_11 < var_27_14 then
					arg_24_1.talkMaxDuration = var_27_14

					if var_27_14 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_14 + var_27_10
					end
				end

				arg_24_1.text_.text = var_27_12
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_15 = math.max(var_27_11, arg_24_1.talkMaxDuration)

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_15 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_10) / var_27_15

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_10 + var_27_15 and arg_24_1.time_ < var_27_10 + var_27_15 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play939021007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 939021007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play939021008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1054ui_story"]) and arg_28_1.var_.characterEffect1054ui_story == nil then
				arg_28_1.var_.characterEffect1054ui_story = arg_28_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1054ui_story"]) then
				if arg_28_1.var_.characterEffect1054ui_story and not isNil(arg_28_1.actors_["1054ui_story"]) then
					arg_28_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_0)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1054ui_story"]) and arg_28_1.var_.characterEffect1054ui_story then
				arg_28_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_31_1 = 0
			local var_31_2 = 0.2

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_3 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(939021007).content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 8 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 8)

				if (8 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 8)) > 0 and var_31_2 < var_31_5 then
					arg_28_1.talkMaxDuration = var_31_5

					if var_31_5 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_6 = math.max(var_31_2, arg_28_1.talkMaxDuration)

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_6 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_1) / var_31_6

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_1 + var_31_6 and arg_28_1.time_ < var_31_1 + var_31_6 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play939021008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 939021008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play939021009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1284ui_story = arg_32_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_35_0 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 then
				arg_32_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_32_1.time_ - 0) / var_35_0)
				arg_32_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1284ui_story"].transform.position).z)
				arg_32_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1284ui_story"].transform.localEulerAngles = arg_32_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 then
				arg_32_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.22)
				arg_32_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1284ui_story"].transform.position).z)
				arg_32_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1284ui_story"].transform.localEulerAngles = arg_32_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_35_1 = arg_32_1.actors_["1054ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1054ui_story = var_35_1.localPosition

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_1.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end
			end

			local var_35_3 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 then
				var_35_1.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_32_1.time_ - 0) / var_35_3)
				var_35_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_1.position).x, (manager.ui.mainCamera.transform.position - var_35_1.position).y, (manager.ui.mainCamera.transform.position - var_35_1.position).z)
				var_35_1.localEulerAngles.z = 0
				var_35_1.localEulerAngles.x = 0
				var_35_1.localEulerAngles = var_35_1.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 then
				var_35_1.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_35_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_1.position).x, (manager.ui.mainCamera.transform.position - var_35_1.position).y, (manager.ui.mainCamera.transform.position - var_35_1.position).z)
				var_35_1.localEulerAngles.z = 0
				var_35_1.localEulerAngles.x = 0
				var_35_1.localEulerAngles = var_35_1.localEulerAngles

				local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_1.gameObject, typeof(DynamicBoneHelper))

				if var_35_4 then
					var_35_4:EnableDynamicBone(true)
				end
			end

			local var_35_5 = arg_32_1.actors_["1284ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect1284ui_story == nil then
				arg_32_1.var_.characterEffect1284ui_story = var_35_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_6 and not isNil(var_35_5) then
				if arg_32_1.var_.characterEffect1284ui_story and not isNil(var_35_5) then
					arg_32_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_6 and arg_32_1.time_ < 0 + var_35_6 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect1284ui_story then
				arg_32_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_35_8 = 0
			local var_35_9 = 0.475

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_8 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_10 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(939021008).content)

				arg_32_1.text_.text = var_35_10

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_12 = 19 <= 0 and var_35_9 or var_35_9 * (utf8.len(var_35_10) / 19)

				if (19 <= 0 and var_35_9 or var_35_9 * (utf8.len(var_35_10) / 19)) > 0 and var_35_9 < var_35_12 then
					arg_32_1.talkMaxDuration = var_35_12

					if var_35_12 + var_35_8 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_12 + var_35_8
					end
				end

				arg_32_1.text_.text = var_35_10
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_13 = math.max(var_35_9, arg_32_1.talkMaxDuration)

			if var_35_8 <= arg_32_1.time_ and arg_32_1.time_ < var_35_8 + var_35_13 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_8) / var_35_13

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_8 + var_35_13 and arg_32_1.time_ < var_35_8 + var_35_13 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play939021009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 939021009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play939021010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1284ui_story = arg_36_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_39_0 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 then
				arg_36_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_0)
				arg_36_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1284ui_story"].transform.position).z)
				arg_36_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1284ui_story"].transform.localEulerAngles = arg_36_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 then
				arg_36_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1284ui_story"].transform.position).z)
				arg_36_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1284ui_story"].transform.localEulerAngles = arg_36_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_39_1 = arg_36_1.actors_["1054ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1054ui_story = var_39_1.localPosition

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_1.gameObject, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end
			end

			local var_39_3 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 then
				var_39_1.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_3)
				var_39_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_1.position).x, (manager.ui.mainCamera.transform.position - var_39_1.position).y, (manager.ui.mainCamera.transform.position - var_39_1.position).z)
				var_39_1.localEulerAngles.z = 0
				var_39_1.localEulerAngles.x = 0
				var_39_1.localEulerAngles = var_39_1.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 then
				var_39_1.localPosition = Vector3.New(0, 100, 0)
				var_39_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_1.position).x, (manager.ui.mainCamera.transform.position - var_39_1.position).y, (manager.ui.mainCamera.transform.position - var_39_1.position).z)
				var_39_1.localEulerAngles.z = 0
				var_39_1.localEulerAngles.x = 0
				var_39_1.localEulerAngles = var_39_1.localEulerAngles

				local var_39_4 = GameObjectTools.GetOrAddComponent(var_39_1.gameObject, typeof(DynamicBoneHelper))

				if var_39_4 then
					var_39_4:EnableDynamicBone(true)
				end
			end

			local var_39_5 = arg_36_1.actors_["1284ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect1284ui_story == nil then
				arg_36_1.var_.characterEffect1284ui_story = var_39_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_6 and not isNil(var_39_5) then
				if arg_36_1.var_.characterEffect1284ui_story and not isNil(var_39_5) then
					arg_36_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_6)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_6 and arg_36_1.time_ < 0 + var_39_6 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect1284ui_story then
				arg_36_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_39_7 = 0
			local var_39_8 = 0.725

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_7 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_9 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(939021009).content)

				arg_36_1.text_.text = var_39_9

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 29 <= 0 and var_39_8 or var_39_8 * (utf8.len(var_39_9) / 29)

				if (29 <= 0 and var_39_8 or var_39_8 * (utf8.len(var_39_9) / 29)) > 0 and var_39_8 < var_39_11 then
					arg_36_1.talkMaxDuration = var_39_11

					if var_39_11 + var_39_7 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_11 + var_39_7
					end
				end

				arg_36_1.text_.text = var_39_9
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_12 = math.max(var_39_8, arg_36_1.talkMaxDuration)

			if var_39_7 <= arg_36_1.time_ and arg_36_1.time_ < var_39_7 + var_39_12 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_7) / var_39_12

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_7 + var_39_12 and arg_36_1.time_ < var_39_7 + var_39_12 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play939021010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 939021010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play939021011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.725

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_1 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(939021010).content)

				arg_40_1.text_.text = var_43_1

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_3 = 29 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 29)

				if (29 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 29)) > 0 and var_43_0 < var_43_3 then
					arg_40_1.talkMaxDuration = var_43_3

					if var_43_3 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_3 + 0
					end
				end

				arg_40_1.text_.text = var_43_1
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_4 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_4

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play939021011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 939021011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play939021012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1284ui_story = arg_44_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_47_0 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 then
				arg_44_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_44_1.time_ - 0) / var_47_0)
				arg_44_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1284ui_story"].transform.position).z)
				arg_44_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1284ui_story"].transform.localEulerAngles = arg_44_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 then
				arg_44_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.22)
				arg_44_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1284ui_story"].transform.position).z)
				arg_44_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1284ui_story"].transform.localEulerAngles = arg_44_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_47_1 = arg_44_1.actors_["1284ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1284ui_story == nil then
				arg_44_1.var_.characterEffect1284ui_story = var_47_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_2 and not isNil(var_47_1) then
				if arg_44_1.var_.characterEffect1284ui_story and not isNil(var_47_1) then
					arg_44_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_2 and arg_44_1.time_ < 0 + var_47_2 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1284ui_story then
				arg_44_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_1")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanL", "EmotionTimelineAnimator")
			end

			local var_47_4 = 0
			local var_47_5 = 1.25

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(939021011).content)

				arg_44_1.text_.text = var_47_6

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_8 = 50 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_6) / 50)

				if (50 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_6) / 50)) > 0 and var_47_5 < var_47_8 then
					arg_44_1.talkMaxDuration = var_47_8

					if var_47_8 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_6
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_9 = math.max(var_47_5, arg_44_1.talkMaxDuration)

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_9 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_4) / var_47_9

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_4 + var_47_9 and arg_44_1.time_ < var_47_4 + var_47_9 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play939021012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 939021012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play939021013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1284ui_story"]) and arg_48_1.var_.characterEffect1284ui_story == nil then
				arg_48_1.var_.characterEffect1284ui_story = arg_48_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1284ui_story"]) then
				if arg_48_1.var_.characterEffect1284ui_story and not isNil(arg_48_1.actors_["1284ui_story"]) then
					arg_48_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_0)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1284ui_story"]) and arg_48_1.var_.characterEffect1284ui_story then
				arg_48_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_51_1 = 0
			local var_51_2 = 0.45

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_3 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(939021012).content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 18 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 18)

				if (18 <= 0 and var_51_2 or var_51_2 * (utf8.len(var_51_3) / 18)) > 0 and var_51_2 < var_51_5 then
					arg_48_1.talkMaxDuration = var_51_5

					if var_51_5 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_6 = math.max(var_51_2, arg_48_1.talkMaxDuration)

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_6 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_1) / var_51_6

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_1 + var_51_6 and arg_48_1.time_ < var_51_1 + var_51_6 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play939021013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 939021013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play939021014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1284ui_story = arg_52_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_55_0 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 then
				arg_52_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_0)
				arg_52_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1284ui_story"].transform.position).z)
				arg_52_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1284ui_story"].transform.localEulerAngles = arg_52_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 then
				arg_52_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1284ui_story"].transform.position).z)
				arg_52_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1284ui_story"].transform.localEulerAngles = arg_52_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_55_1 = 0
			local var_55_2 = 0.875

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_3 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(939021013).content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 35 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_3) / 35)

				if (35 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_3) / 35)) > 0 and var_55_2 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_1
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_6 = math.max(var_55_2, arg_52_1.talkMaxDuration)

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_6 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_1) / var_55_6

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_1 + var_55_6 and arg_52_1.time_ < var_55_1 + var_55_6 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play939021014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 939021014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play939021015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1054ui_story = arg_56_1.actors_["1054ui_story"].transform.localPosition

				local var_59_0 = GameObjectTools.GetOrAddComponent(arg_56_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_59_0 then
					var_59_0:EnableDynamicBone(false)
				end
			end

			local var_59_1 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_1 then
				arg_56_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_56_1.time_ - 0) / var_59_1)
				arg_56_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1054ui_story"].transform.position).z)
				arg_56_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1054ui_story"].transform.localEulerAngles = arg_56_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_1 and arg_56_1.time_ < 0 + var_59_1 + arg_59_0 then
				arg_56_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_56_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["1054ui_story"].transform.position).z)
				arg_56_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["1054ui_story"].transform.localEulerAngles = arg_56_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_59_2 = GameObjectTools.GetOrAddComponent(arg_56_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_59_2 then
					var_59_2:EnableDynamicBone(true)
				end
			end

			local var_59_3 = arg_56_1.actors_["1054ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_3) and arg_56_1.var_.characterEffect1054ui_story == nil then
				arg_56_1.var_.characterEffect1054ui_story = var_59_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_4 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 and not isNil(var_59_3) then
				if arg_56_1.var_.characterEffect1054ui_story and not isNil(var_59_3) then
					arg_56_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 and not isNil(var_59_3) and arg_56_1.var_.characterEffect1054ui_story then
				arg_56_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054actionlink/1054action456")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_59_6 = 0
			local var_59_7 = 1.125

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_8 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(939021014).content)

				arg_56_1.text_.text = var_59_8

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_10 = 45 <= 0 and var_59_7 or var_59_7 * (utf8.len(var_59_8) / 45)

				if (45 <= 0 and var_59_7 or var_59_7 * (utf8.len(var_59_8) / 45)) > 0 and var_59_7 < var_59_10 then
					arg_56_1.talkMaxDuration = var_59_10

					if var_59_10 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_8
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_11 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_11 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_11

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_11 and arg_56_1.time_ < var_59_6 + var_59_11 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play939021015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 939021015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play939021016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1054ui_story"]) and arg_60_1.var_.characterEffect1054ui_story == nil then
				arg_60_1.var_.characterEffect1054ui_story = arg_60_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1054ui_story"]) then
				if arg_60_1.var_.characterEffect1054ui_story and not isNil(arg_60_1.actors_["1054ui_story"]) then
					arg_60_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_0)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1054ui_story"]) and arg_60_1.var_.characterEffect1054ui_story then
				arg_60_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_63_1 = 0
			local var_63_2 = 0.6

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_3 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(939021015).content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 24 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_3) / 24)

				if (24 <= 0 and var_63_2 or var_63_2 * (utf8.len(var_63_3) / 24)) > 0 and var_63_2 < var_63_5 then
					arg_60_1.talkMaxDuration = var_63_5

					if var_63_5 + var_63_1 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + var_63_1
					end
				end

				arg_60_1.text_.text = var_63_3
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_6 = math.max(var_63_2, arg_60_1.talkMaxDuration)

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_6 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_1) / var_63_6

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_1 + var_63_6 and arg_60_1.time_ < var_63_1 + var_63_6 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play939021016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 939021016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play939021017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1054ui_story = arg_64_1.actors_["1054ui_story"].transform.localPosition

				local var_67_0 = GameObjectTools.GetOrAddComponent(arg_64_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_67_0 then
					var_67_0:EnableDynamicBone(false)
				end
			end

			local var_67_1 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_1 then
				arg_64_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_1)
				arg_64_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1054ui_story"].transform.position).z)
				arg_64_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1054ui_story"].transform.localEulerAngles = arg_64_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_1 and arg_64_1.time_ < 0 + var_67_1 + arg_67_0 then
				arg_64_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["1054ui_story"].transform.position).z)
				arg_64_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["1054ui_story"].transform.localEulerAngles = arg_64_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_67_2 = GameObjectTools.GetOrAddComponent(arg_64_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(true)
				end
			end

			local var_67_3 = 0
			local var_67_4 = 0.6

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_3 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_5 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(939021016).content)

				arg_64_1.text_.text = var_67_5

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_7 = 24 <= 0 and var_67_4 or var_67_4 * (utf8.len(var_67_5) / 24)

				if (24 <= 0 and var_67_4 or var_67_4 * (utf8.len(var_67_5) / 24)) > 0 and var_67_4 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_3 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_3
					end
				end

				arg_64_1.text_.text = var_67_5
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_8 = math.max(var_67_4, arg_64_1.talkMaxDuration)

			if var_67_3 <= arg_64_1.time_ and arg_64_1.time_ < var_67_3 + var_67_8 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_3) / var_67_8

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_3 + var_67_8 and arg_64_1.time_ < var_67_3 + var_67_8 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play939021017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 939021017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play939021018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1054ui_story = arg_68_1.actors_["1054ui_story"].transform.localPosition

				local var_71_0 = GameObjectTools.GetOrAddComponent(arg_68_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_71_0 then
					var_71_0:EnableDynamicBone(false)
				end
			end

			local var_71_1 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_1 then
				arg_68_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_68_1.time_ - 0) / var_71_1)
				arg_68_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1054ui_story"].transform.position).z)
				arg_68_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1054ui_story"].transform.localEulerAngles = arg_68_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_1 and arg_68_1.time_ < 0 + var_71_1 + arg_71_0 then
				arg_68_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_68_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_68_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_68_1.actors_["1054ui_story"].transform.position).z)
				arg_68_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_68_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_68_1.actors_["1054ui_story"].transform.localEulerAngles = arg_68_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_71_2 = GameObjectTools.GetOrAddComponent(arg_68_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_71_2 then
					var_71_2:EnableDynamicBone(true)
				end
			end

			local var_71_3 = arg_68_1.actors_["1054ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_3) and arg_68_1.var_.characterEffect1054ui_story == nil then
				arg_68_1.var_.characterEffect1054ui_story = var_71_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_4 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 and not isNil(var_71_3) then
				if arg_68_1.var_.characterEffect1054ui_story and not isNil(var_71_3) then
					arg_68_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 and not isNil(var_71_3) and arg_68_1.var_.characterEffect1054ui_story then
				arg_68_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_2")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_71_6 = 0
			local var_71_7 = 0.575

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_8 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(939021017).content)

				arg_68_1.text_.text = var_71_8

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_10 = 23 <= 0 and var_71_7 or var_71_7 * (utf8.len(var_71_8) / 23)

				if (23 <= 0 and var_71_7 or var_71_7 * (utf8.len(var_71_8) / 23)) > 0 and var_71_7 < var_71_10 then
					arg_68_1.talkMaxDuration = var_71_10

					if var_71_10 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_6
					end
				end

				arg_68_1.text_.text = var_71_8
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_11 = math.max(var_71_7, arg_68_1.talkMaxDuration)

			if var_71_6 <= arg_68_1.time_ and arg_68_1.time_ < var_71_6 + var_71_11 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_6) / var_71_11

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_6 + var_71_11 and arg_68_1.time_ < var_71_6 + var_71_11 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play939021018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 939021018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play939021019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1054ui_story"]) and arg_72_1.var_.characterEffect1054ui_story == nil then
				arg_72_1.var_.characterEffect1054ui_story = arg_72_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1054ui_story"]) then
				if arg_72_1.var_.characterEffect1054ui_story and not isNil(arg_72_1.actors_["1054ui_story"]) then
					arg_72_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_0)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1054ui_story"]) and arg_72_1.var_.characterEffect1054ui_story then
				arg_72_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_75_1 = 0
			local var_75_2 = 0.9

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_3 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(939021018).content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 36 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 36)

				if (36 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_3) / 36)) > 0 and var_75_2 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_1
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_6 = math.max(var_75_2, arg_72_1.talkMaxDuration)

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_6 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_1) / var_75_6

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_1 + var_75_6 and arg_72_1.time_ < var_75_1 + var_75_6 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play939021019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 939021019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play939021020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if arg_76_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_79_0 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_76_1.stage_.transform)

				var_79_0.name = "6148ui_story"
				var_79_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.actors_["6148ui_story"] = var_79_0

				local var_79_1 = var_79_0:GetComponentInChildren(typeof(CharacterEffect))

				var_79_1.enabled = true

				local var_79_2 = GameObjectTools.GetOrAddComponent(var_79_0, typeof(DynamicBoneHelper))

				if var_79_2 then
					var_79_2:EnableDynamicBone(false)
				end

				arg_76_1:ShowWeapon(var_79_1.transform, false)

				arg_76_1.var_["6148ui_story" .. "Animator"] = var_79_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_76_1.var_["6148ui_story" .. "Animator"].applyRootMotion = true
				arg_76_1.var_["6148ui_story" .. "LipSync"] = var_79_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_79_3 = arg_76_1.actors_["6148ui_story"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos6148ui_story = var_79_3.localPosition

				local var_79_4 = GameObjectTools.GetOrAddComponent(var_79_3.gameObject, typeof(DynamicBoneHelper))

				if var_79_4 then
					var_79_4:EnableDynamicBone(false)
				end
			end

			local var_79_5 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_5 then
				var_79_3.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_76_1.time_ - 0) / var_79_5)
				var_79_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_3.position).x, (manager.ui.mainCamera.transform.position - var_79_3.position).y, (manager.ui.mainCamera.transform.position - var_79_3.position).z)
				var_79_3.localEulerAngles.z = 0
				var_79_3.localEulerAngles.x = 0
				var_79_3.localEulerAngles = var_79_3.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_5 and arg_76_1.time_ < 0 + var_79_5 + arg_79_0 then
				var_79_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_79_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_3.position).x, (manager.ui.mainCamera.transform.position - var_79_3.position).y, (manager.ui.mainCamera.transform.position - var_79_3.position).z)
				var_79_3.localEulerAngles.z = 0
				var_79_3.localEulerAngles.x = 0
				var_79_3.localEulerAngles = var_79_3.localEulerAngles

				local var_79_6 = GameObjectTools.GetOrAddComponent(var_79_3.gameObject, typeof(DynamicBoneHelper))

				if var_79_6 then
					var_79_6:EnableDynamicBone(true)
				end
			end

			local var_79_7 = arg_76_1.actors_["6148ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_7) and arg_76_1.var_.characterEffect6148ui_story == nil then
				arg_76_1.var_.characterEffect6148ui_story = var_79_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_8 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_8 and not isNil(var_79_7) then
				if arg_76_1.var_.characterEffect6148ui_story and not isNil(var_79_7) then
					arg_76_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_8 and arg_76_1.time_ < 0 + var_79_8 + arg_79_0 and not isNil(var_79_7) and arg_76_1.var_.characterEffect6148ui_story then
				arg_76_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_79_10 = 0
			local var_79_11 = 1.4

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_12 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(939021019).content)

				arg_76_1.text_.text = var_79_12

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_14 = 56 <= 0 and var_79_11 or var_79_11 * (utf8.len(var_79_12) / 56)

				if (56 <= 0 and var_79_11 or var_79_11 * (utf8.len(var_79_12) / 56)) > 0 and var_79_11 < var_79_14 then
					arg_76_1.talkMaxDuration = var_79_14

					if var_79_14 + var_79_10 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_14 + var_79_10
					end
				end

				arg_76_1.text_.text = var_79_12
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_15 = math.max(var_79_11, arg_76_1.talkMaxDuration)

			if var_79_10 <= arg_76_1.time_ and arg_76_1.time_ < var_79_10 + var_79_15 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_10) / var_79_15

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_10 + var_79_15 and arg_76_1.time_ < var_79_10 + var_79_15 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play939021020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 939021020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play939021021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if arg_80_1.actors_["1211ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1211ui_story"))) then
				local var_83_0 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_80_1.stage_.transform)

				var_83_0.name = "1211ui_story"
				var_83_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_80_1.actors_["1211ui_story"] = var_83_0

				local var_83_1 = var_83_0:GetComponentInChildren(typeof(CharacterEffect))

				var_83_1.enabled = true

				local var_83_2 = GameObjectTools.GetOrAddComponent(var_83_0, typeof(DynamicBoneHelper))

				if var_83_2 then
					var_83_2:EnableDynamicBone(false)
				end

				arg_80_1:ShowWeapon(var_83_1.transform, false)

				arg_80_1.var_["1211ui_story" .. "Animator"] = var_83_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_80_1.var_["1211ui_story" .. "Animator"].applyRootMotion = true
				arg_80_1.var_["1211ui_story" .. "LipSync"] = var_83_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_83_3 = arg_80_1.actors_["1211ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1211ui_story = var_83_3.localPosition
			end

			local var_83_4 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				var_83_3.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_80_1.time_ - 0) / var_83_4)
				var_83_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_3.position).x, (manager.ui.mainCamera.transform.position - var_83_3.position).y, (manager.ui.mainCamera.transform.position - var_83_3.position).z)
				var_83_3.localEulerAngles.z = 0
				var_83_3.localEulerAngles.x = 0
				var_83_3.localEulerAngles = var_83_3.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				var_83_3.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				var_83_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_3.position).x, (manager.ui.mainCamera.transform.position - var_83_3.position).y, (manager.ui.mainCamera.transform.position - var_83_3.position).z)
				var_83_3.localEulerAngles.z = 0
				var_83_3.localEulerAngles.x = 0
				var_83_3.localEulerAngles = var_83_3.localEulerAngles
			end

			local var_83_5 = arg_80_1.actors_["1054ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1054ui_story = var_83_5.localPosition

				local var_83_6 = GameObjectTools.GetOrAddComponent(var_83_5.gameObject, typeof(DynamicBoneHelper))

				if var_83_6 then
					var_83_6:EnableDynamicBone(false)
				end
			end

			local var_83_7 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_7 then
				var_83_5.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_7)
				var_83_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_5.position).x, (manager.ui.mainCamera.transform.position - var_83_5.position).y, (manager.ui.mainCamera.transform.position - var_83_5.position).z)
				var_83_5.localEulerAngles.z = 0
				var_83_5.localEulerAngles.x = 0
				var_83_5.localEulerAngles = var_83_5.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_7 and arg_80_1.time_ < 0 + var_83_7 + arg_83_0 then
				var_83_5.localPosition = Vector3.New(0, 100, 0)
				var_83_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_5.position).x, (manager.ui.mainCamera.transform.position - var_83_5.position).y, (manager.ui.mainCamera.transform.position - var_83_5.position).z)
				var_83_5.localEulerAngles.z = 0
				var_83_5.localEulerAngles.x = 0
				var_83_5.localEulerAngles = var_83_5.localEulerAngles

				local var_83_8 = GameObjectTools.GetOrAddComponent(var_83_5.gameObject, typeof(DynamicBoneHelper))

				if var_83_8 then
					var_83_8:EnableDynamicBone(true)
				end
			end

			local var_83_9 = arg_80_1.actors_["1211ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_9) and arg_80_1.var_.characterEffect1211ui_story == nil then
				arg_80_1.var_.characterEffect1211ui_story = var_83_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_10 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_10 and not isNil(var_83_9) then
				if arg_80_1.var_.characterEffect1211ui_story and not isNil(var_83_9) then
					arg_80_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_10 and arg_80_1.time_ < 0 + var_83_10 + arg_83_0 and not isNil(var_83_9) and arg_80_1.var_.characterEffect1211ui_story then
				arg_80_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_83_12 = arg_80_1.actors_["6148ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_12) and arg_80_1.var_.characterEffect6148ui_story == nil then
				arg_80_1.var_.characterEffect6148ui_story = var_83_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_13 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_13 and not isNil(var_83_12) then
				if arg_80_1.var_.characterEffect6148ui_story and not isNil(var_83_12) then
					arg_80_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_80_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_13)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_13 and arg_80_1.time_ < 0 + var_83_13 + arg_83_0 and not isNil(var_83_12) and arg_80_1.var_.characterEffect6148ui_story then
				arg_80_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_80_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action1_1")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_83_14 = 0
			local var_83_15 = 0.475

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_14 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_16 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(939021020).content)

				arg_80_1.text_.text = var_83_16

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_18 = 19 <= 0 and var_83_15 or var_83_15 * (utf8.len(var_83_16) / 19)

				if (19 <= 0 and var_83_15 or var_83_15 * (utf8.len(var_83_16) / 19)) > 0 and var_83_15 < var_83_18 then
					arg_80_1.talkMaxDuration = var_83_18

					if var_83_18 + var_83_14 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_18 + var_83_14
					end
				end

				arg_80_1.text_.text = var_83_16
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_19 = math.max(var_83_15, arg_80_1.talkMaxDuration)

			if var_83_14 <= arg_80_1.time_ and arg_80_1.time_ < var_83_14 + var_83_19 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_14) / var_83_19

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_14 + var_83_19 and arg_80_1.time_ < var_83_14 + var_83_19 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play939021021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 939021021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play939021022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1284ui_story = arg_84_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_87_0 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 then
				arg_84_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_84_1.time_ - 0) / var_87_0)
				arg_84_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1284ui_story"].transform.position).z)
				arg_84_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1284ui_story"].transform.localEulerAngles = arg_84_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 then
				arg_84_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.22)
				arg_84_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["1284ui_story"].transform.position).z)
				arg_84_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["1284ui_story"].transform.localEulerAngles = arg_84_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_87_1 = arg_84_1.actors_["6148ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos6148ui_story = var_87_1.localPosition

				local var_87_2 = GameObjectTools.GetOrAddComponent(var_87_1.gameObject, typeof(DynamicBoneHelper))

				if var_87_2 then
					var_87_2:EnableDynamicBone(false)
				end
			end

			local var_87_3 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_3 then
				var_87_1.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_3)
				var_87_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_1.position).x, (manager.ui.mainCamera.transform.position - var_87_1.position).y, (manager.ui.mainCamera.transform.position - var_87_1.position).z)
				var_87_1.localEulerAngles.z = 0
				var_87_1.localEulerAngles.x = 0
				var_87_1.localEulerAngles = var_87_1.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_3 and arg_84_1.time_ < 0 + var_87_3 + arg_87_0 then
				var_87_1.localPosition = Vector3.New(0, 100, 0)
				var_87_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_1.position).x, (manager.ui.mainCamera.transform.position - var_87_1.position).y, (manager.ui.mainCamera.transform.position - var_87_1.position).z)
				var_87_1.localEulerAngles.z = 0
				var_87_1.localEulerAngles.x = 0
				var_87_1.localEulerAngles = var_87_1.localEulerAngles

				local var_87_4 = GameObjectTools.GetOrAddComponent(var_87_1.gameObject, typeof(DynamicBoneHelper))

				if var_87_4 then
					var_87_4:EnableDynamicBone(true)
				end
			end

			local var_87_5 = arg_84_1.actors_["1284ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_5) and arg_84_1.var_.characterEffect1284ui_story == nil then
				arg_84_1.var_.characterEffect1284ui_story = var_87_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_6 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_6 and not isNil(var_87_5) then
				if arg_84_1.var_.characterEffect1284ui_story and not isNil(var_87_5) then
					arg_84_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_6 and arg_84_1.time_ < 0 + var_87_6 + arg_87_0 and not isNil(var_87_5) and arg_84_1.var_.characterEffect1284ui_story then
				arg_84_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_87_8 = arg_84_1.actors_["1211ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_8) and arg_84_1.var_.characterEffect1211ui_story == nil then
				arg_84_1.var_.characterEffect1211ui_story = var_87_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_9 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_9 and not isNil(var_87_8) then
				if arg_84_1.var_.characterEffect1211ui_story and not isNil(var_87_8) then
					arg_84_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_9)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_9 and arg_84_1.time_ < 0 + var_87_9 + arg_87_0 and not isNil(var_87_8) and arg_84_1.var_.characterEffect1211ui_story then
				arg_84_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_87_10 = 0
			local var_87_11 = 0.25

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_12 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(939021021).content)

				arg_84_1.text_.text = var_87_12

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_14 = 10 <= 0 and var_87_11 or var_87_11 * (utf8.len(var_87_12) / 10)

				if (10 <= 0 and var_87_11 or var_87_11 * (utf8.len(var_87_12) / 10)) > 0 and var_87_11 < var_87_14 then
					arg_84_1.talkMaxDuration = var_87_14

					if var_87_14 + var_87_10 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_14 + var_87_10
					end
				end

				arg_84_1.text_.text = var_87_12
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_15 = math.max(var_87_11, arg_84_1.talkMaxDuration)

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_15 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_10) / var_87_15

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_10 + var_87_15 and arg_84_1.time_ < var_87_10 + var_87_15 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play939021022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 939021022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play939021023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1284ui_story = arg_88_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_91_0 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 then
				arg_88_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_88_1.time_ - 0) / var_91_0)
				arg_88_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1284ui_story"].transform.position).z)
				arg_88_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1284ui_story"].transform.localEulerAngles = arg_88_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 then
				arg_88_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1284ui_story"].transform.position).z)
				arg_88_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1284ui_story"].transform.localEulerAngles = arg_88_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_91_1 = arg_88_1.actors_["1211ui_story"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1211ui_story = var_91_1.localPosition
			end

			local var_91_2 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_2 then
				var_91_1.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_88_1.time_ - 0) / var_91_2)
				var_91_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_1.position).x, (manager.ui.mainCamera.transform.position - var_91_1.position).y, (manager.ui.mainCamera.transform.position - var_91_1.position).z)
				var_91_1.localEulerAngles.z = 0
				var_91_1.localEulerAngles.x = 0
				var_91_1.localEulerAngles = var_91_1.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_2 and arg_88_1.time_ < 0 + var_91_2 + arg_91_0 then
				var_91_1.localPosition = Vector3.New(0, 100, 0)
				var_91_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_1.position).x, (manager.ui.mainCamera.transform.position - var_91_1.position).y, (manager.ui.mainCamera.transform.position - var_91_1.position).z)
				var_91_1.localEulerAngles.z = 0
				var_91_1.localEulerAngles.x = 0
				var_91_1.localEulerAngles = var_91_1.localEulerAngles
			end

			local var_91_3 = arg_88_1.actors_["1284ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_3) and arg_88_1.var_.characterEffect1284ui_story == nil then
				arg_88_1.var_.characterEffect1284ui_story = var_91_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_4 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 and not isNil(var_91_3) then
				if arg_88_1.var_.characterEffect1284ui_story and not isNil(var_91_3) then
					arg_88_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_4)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 and not isNil(var_91_3) and arg_88_1.var_.characterEffect1284ui_story then
				arg_88_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_91_5 = 0
			local var_91_6 = 0.8

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_7 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(939021022).content)

				arg_88_1.text_.text = var_91_7

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_9 = 32 <= 0 and var_91_6 or var_91_6 * (utf8.len(var_91_7) / 32)

				if (32 <= 0 and var_91_6 or var_91_6 * (utf8.len(var_91_7) / 32)) > 0 and var_91_6 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_5
					end
				end

				arg_88_1.text_.text = var_91_7
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_6, arg_88_1.talkMaxDuration)

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_5) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_5 + var_91_10 and arg_88_1.time_ < var_91_5 + var_91_10 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play939021023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 939021023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play939021024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1054ui_story = arg_92_1.actors_["1054ui_story"].transform.localPosition

				local var_95_0 = GameObjectTools.GetOrAddComponent(arg_92_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_95_0 then
					var_95_0:EnableDynamicBone(false)
				end
			end

			local var_95_1 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_1 then
				arg_92_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_92_1.time_ - 0) / var_95_1)
				arg_92_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1054ui_story"].transform.position).z)
				arg_92_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1054ui_story"].transform.localEulerAngles = arg_92_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_1 and arg_92_1.time_ < 0 + var_95_1 + arg_95_0 then
				arg_92_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_92_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1054ui_story"].transform.position).z)
				arg_92_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1054ui_story"].transform.localEulerAngles = arg_92_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_95_2 = GameObjectTools.GetOrAddComponent(arg_92_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(true)
				end
			end

			local var_95_3 = arg_92_1.actors_["1054ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_3) and arg_92_1.var_.characterEffect1054ui_story == nil then
				arg_92_1.var_.characterEffect1054ui_story = var_95_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_4 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 and not isNil(var_95_3) then
				if arg_92_1.var_.characterEffect1054ui_story and not isNil(var_95_3) then
					arg_92_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 and not isNil(var_95_3) and arg_92_1.var_.characterEffect1054ui_story then
				arg_92_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_95_6 = 0
			local var_95_7 = 0.65

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_8 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(939021023).content)

				arg_92_1.text_.text = var_95_8

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_10 = 26 <= 0 and var_95_7 or var_95_7 * (utf8.len(var_95_8) / 26)

				if (26 <= 0 and var_95_7 or var_95_7 * (utf8.len(var_95_8) / 26)) > 0 and var_95_7 < var_95_10 then
					arg_92_1.talkMaxDuration = var_95_10

					if var_95_10 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_10 + var_95_6
					end
				end

				arg_92_1.text_.text = var_95_8
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_11 = math.max(var_95_7, arg_92_1.talkMaxDuration)

			if var_95_6 <= arg_92_1.time_ and arg_92_1.time_ < var_95_6 + var_95_11 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_6) / var_95_11

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_6 + var_95_11 and arg_92_1.time_ < var_95_6 + var_95_11 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play939021024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 939021024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play939021025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos6148ui_story = arg_96_1.actors_["6148ui_story"].transform.localPosition

				local var_99_0 = GameObjectTools.GetOrAddComponent(arg_96_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_99_0 then
					var_99_0:EnableDynamicBone(false)
				end
			end

			local var_99_1 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_1 then
				arg_96_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_96_1.time_ - 0) / var_99_1)
				arg_96_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["6148ui_story"].transform.position).z)
				arg_96_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["6148ui_story"].transform.localEulerAngles = arg_96_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_1 and arg_96_1.time_ < 0 + var_99_1 + arg_99_0 then
				arg_96_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_96_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["6148ui_story"].transform.position).z)
				arg_96_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["6148ui_story"].transform.localEulerAngles = arg_96_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_99_2 = GameObjectTools.GetOrAddComponent(arg_96_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_99_2 then
					var_99_2:EnableDynamicBone(true)
				end
			end

			local var_99_3 = arg_96_1.actors_["6148ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_3) and arg_96_1.var_.characterEffect6148ui_story == nil then
				arg_96_1.var_.characterEffect6148ui_story = var_99_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_4 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 and not isNil(var_99_3) then
				if arg_96_1.var_.characterEffect6148ui_story and not isNil(var_99_3) then
					arg_96_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 and not isNil(var_99_3) and arg_96_1.var_.characterEffect6148ui_story then
				arg_96_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_99_6 = arg_96_1.actors_["1054ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_6) and arg_96_1.var_.characterEffect1054ui_story == nil then
				arg_96_1.var_.characterEffect1054ui_story = var_99_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_7 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_7 and not isNil(var_99_6) then
				if arg_96_1.var_.characterEffect1054ui_story and not isNil(var_99_6) then
					arg_96_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_7)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_7 and arg_96_1.time_ < 0 + var_99_7 + arg_99_0 and not isNil(var_99_6) and arg_96_1.var_.characterEffect1054ui_story then
				arg_96_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_99_8 = 0
			local var_99_9 = 0.6

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_8 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_10 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(939021024).content)

				arg_96_1.text_.text = var_99_10

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_12 = 24 <= 0 and var_99_9 or var_99_9 * (utf8.len(var_99_10) / 24)

				if (24 <= 0 and var_99_9 or var_99_9 * (utf8.len(var_99_10) / 24)) > 0 and var_99_9 < var_99_12 then
					arg_96_1.talkMaxDuration = var_99_12

					if var_99_12 + var_99_8 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_12 + var_99_8
					end
				end

				arg_96_1.text_.text = var_99_10
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_13 = math.max(var_99_9, arg_96_1.talkMaxDuration)

			if var_99_8 <= arg_96_1.time_ and arg_96_1.time_ < var_99_8 + var_99_13 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_8) / var_99_13

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_8 + var_99_13 and arg_96_1.time_ < var_99_8 + var_99_13 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play939021025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 939021025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play939021026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos6148ui_story = arg_100_1.actors_["6148ui_story"].transform.localPosition

				local var_103_0 = GameObjectTools.GetOrAddComponent(arg_100_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_103_0 then
					var_103_0:EnableDynamicBone(false)
				end
			end

			local var_103_1 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_1 then
				arg_100_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_100_1.time_ - 0) / var_103_1)
				arg_100_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["6148ui_story"].transform.position).z)
				arg_100_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["6148ui_story"].transform.localEulerAngles = arg_100_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_1 and arg_100_1.time_ < 0 + var_103_1 + arg_103_0 then
				arg_100_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_100_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["6148ui_story"].transform.position).z)
				arg_100_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["6148ui_story"].transform.localEulerAngles = arg_100_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_103_2 = GameObjectTools.GetOrAddComponent(arg_100_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_103_2 then
					var_103_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action458")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanL", "EmotionTimelineAnimator")
			end

			local var_103_3 = 0
			local var_103_4 = 0.275

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_3 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_5 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(939021025).content)

				arg_100_1.text_.text = var_103_5

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 11 <= 0 and var_103_4 or var_103_4 * (utf8.len(var_103_5) / 11)

				if (11 <= 0 and var_103_4 or var_103_4 * (utf8.len(var_103_5) / 11)) > 0 and var_103_4 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_3 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_3
					end
				end

				arg_100_1.text_.text = var_103_5
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_8 = math.max(var_103_4, arg_100_1.talkMaxDuration)

			if var_103_3 <= arg_100_1.time_ and arg_100_1.time_ < var_103_3 + var_103_8 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_3) / var_103_8

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_3 + var_103_8 and arg_100_1.time_ < var_103_3 + var_103_8 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play939021026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 939021026
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play939021027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_9000

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos6148ui_story = arg_104_1.actors_["6148ui_story"].transform.localPosition

				local var_107_0 = GameObjectTools.GetOrAddComponent(arg_104_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_107_0 then
					var_107_0:EnableDynamicBone(false)
				end
			end

			local var_107_1 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_1 then
				arg_104_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_104_1.time_ - 0) / var_107_1)
				arg_104_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["6148ui_story"].transform.position).z)
				arg_104_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["6148ui_story"].transform.localEulerAngles = arg_104_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_1 and arg_104_1.time_ < 0 + var_107_1 + arg_107_0 then
				arg_104_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_104_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_104_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_104_1.actors_["6148ui_story"].transform.position).z)
				arg_104_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_104_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_104_1.actors_["6148ui_story"].transform.localEulerAngles = arg_104_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_107_2 = GameObjectTools.GetOrAddComponent(arg_104_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_107_2 then
					var_107_2:EnableDynamicBone(true)
				end
			end

			local var_107_3 = arg_104_1.actors_["1054ui_story"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1054ui_story = var_107_3.localPosition

				local var_107_4 = GameObjectTools.GetOrAddComponent(var_107_3.gameObject, typeof(DynamicBoneHelper))

				if var_107_4 then
					var_107_4:EnableDynamicBone(false)
				end
			end

			local var_107_5 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_5 then
				var_107_3.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_104_1.time_ - 0) / var_107_5)
				var_107_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_3.position).x, (manager.ui.mainCamera.transform.position - var_107_3.position).y, (manager.ui.mainCamera.transform.position - var_107_3.position).z)
				var_107_3.localEulerAngles.z = 0
				var_107_3.localEulerAngles.x = 0
				var_107_3.localEulerAngles = var_107_3.localEulerAngles
			end

			if arg_104_1.time_ >= 0 + var_107_5 and arg_104_1.time_ < 0 + var_107_5 + arg_107_0 then
				var_107_3.localPosition = Vector3.New(0, 100, 0)
				var_107_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_107_3.position).x, (manager.ui.mainCamera.transform.position - var_107_3.position).y, (manager.ui.mainCamera.transform.position - var_107_3.position).z)
				var_107_3.localEulerAngles.z = 0
				var_107_3.localEulerAngles.x = 0
				var_107_3.localEulerAngles = var_107_3.localEulerAngles

				local var_107_6 = GameObjectTools.GetOrAddComponent(var_107_3.gameObject, typeof(DynamicBoneHelper))

				if var_107_6 then
					var_107_6:EnableDynamicBone(true)
				end
			end

			local var_107_7 = arg_104_1.actors_["6148ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_7) and arg_104_1.var_.characterEffect6148ui_story == nil then
				arg_104_1.var_.characterEffect6148ui_story = var_107_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_8 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_8 and not isNil(var_107_7) then
				if arg_104_1.var_.characterEffect6148ui_story and not isNil(var_107_7) then
					arg_104_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_104_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_8)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_8 and arg_104_1.time_ < 0 + var_107_8 + arg_107_0 and not isNil(var_107_7) and arg_104_1.var_.characterEffect6148ui_story then
				arg_104_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_104_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				local var_107_9 = arg_104_1.var_.effectguaheiban1

				if not arg_104_1.var_.effectguaheiban1 then
					var_107_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_out"), manager.ui.mainCamera.transform)
					var_107_9.name = "guaheiban1"
					arg_104_1.var_.effectguaheiban1 = var_107_9
				else
					var_107_9.transform:SetParent(var_107_9000)
				end

				var_107_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_107_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_107_11 = 0
			local var_107_12 = 1

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_11 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_13 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(939021026).content)

				arg_104_1.text_.text = var_107_13

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_15 = 40 <= 0 and var_107_12 or var_107_12 * (utf8.len(var_107_13) / 40)

				if (40 <= 0 and var_107_12 or var_107_12 * (utf8.len(var_107_13) / 40)) > 0 and var_107_12 < var_107_15 then
					arg_104_1.talkMaxDuration = var_107_15

					if var_107_15 + var_107_11 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_15 + var_107_11
					end
				end

				arg_104_1.text_.text = var_107_13
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_16 = math.max(var_107_12, arg_104_1.talkMaxDuration)

			if var_107_11 <= arg_104_1.time_ and arg_104_1.time_ < var_107_11 + var_107_16 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_11) / var_107_16

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_11 + var_107_16 and arg_104_1.time_ < var_107_11 + var_107_16 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play939021027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 939021027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play939021028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1284ui_story = arg_108_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_111_0 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 then
				arg_108_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_108_1.time_ - 0) / var_111_0)
				arg_108_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1284ui_story"].transform.position).z)
				arg_108_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1284ui_story"].transform.localEulerAngles = arg_108_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 then
				arg_108_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				arg_108_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1284ui_story"].transform.position).z)
				arg_108_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1284ui_story"].transform.localEulerAngles = arg_108_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_111_1 = arg_108_1.actors_["1284ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect1284ui_story == nil then
				arg_108_1.var_.characterEffect1284ui_story = var_111_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_2 and not isNil(var_111_1) then
				if arg_108_1.var_.characterEffect1284ui_story and not isNil(var_111_1) then
					arg_108_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_2 and arg_108_1.time_ < 0 + var_111_2 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect1284ui_story then
				arg_108_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action10_2")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_111_4 = 0
			local var_111_5 = 0.325

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_6 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(939021027).content)

				arg_108_1.text_.text = var_111_6

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_8 = 13 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_6) / 13)

				if (13 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_6) / 13)) > 0 and var_111_5 < var_111_8 then
					arg_108_1.talkMaxDuration = var_111_8

					if var_111_8 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_8 + var_111_4
					end
				end

				arg_108_1.text_.text = var_111_6
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_9 = math.max(var_111_5, arg_108_1.talkMaxDuration)

			if var_111_4 <= arg_108_1.time_ and arg_108_1.time_ < var_111_4 + var_111_9 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_4) / var_111_9

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_4 + var_111_9 and arg_108_1.time_ < var_111_4 + var_111_9 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play939021028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 939021028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play939021029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1211ui_story = arg_112_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_115_0 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 then
				arg_112_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1211ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_112_1.time_ - 0) / var_115_0)
				arg_112_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1211ui_story"].transform.position).z)
				arg_112_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1211ui_story"].transform.localEulerAngles = arg_112_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 then
				arg_112_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0.7, -0.67, -6.07)
				arg_112_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1211ui_story"].transform.position).z)
				arg_112_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1211ui_story"].transform.localEulerAngles = arg_112_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_115_1 = arg_112_1.actors_["1211ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_1) and arg_112_1.var_.characterEffect1211ui_story == nil then
				arg_112_1.var_.characterEffect1211ui_story = var_115_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_2 and not isNil(var_115_1) then
				if arg_112_1.var_.characterEffect1211ui_story and not isNil(var_115_1) then
					arg_112_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_2 and arg_112_1.time_ < 0 + var_115_2 + arg_115_0 and not isNil(var_115_1) and arg_112_1.var_.characterEffect1211ui_story then
				arg_112_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_115_4 = arg_112_1.actors_["1284ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_4) and arg_112_1.var_.characterEffect1284ui_story == nil then
				arg_112_1.var_.characterEffect1284ui_story = var_115_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_5 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_5 and not isNil(var_115_4) then
				if arg_112_1.var_.characterEffect1284ui_story and not isNil(var_115_4) then
					arg_112_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_5)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_5 and arg_112_1.time_ < 0 + var_115_5 + arg_115_0 and not isNil(var_115_4) and arg_112_1.var_.characterEffect1284ui_story then
				arg_112_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action4_1")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_115_6 = 0
			local var_115_7 = 0.35

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_8 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(939021028).content)

				arg_112_1.text_.text = var_115_8

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_10 = 14 <= 0 and var_115_7 or var_115_7 * (utf8.len(var_115_8) / 14)

				if (14 <= 0 and var_115_7 or var_115_7 * (utf8.len(var_115_8) / 14)) > 0 and var_115_7 < var_115_10 then
					arg_112_1.talkMaxDuration = var_115_10

					if var_115_10 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_10 + var_115_6
					end
				end

				arg_112_1.text_.text = var_115_8
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_11 = math.max(var_115_7, arg_112_1.talkMaxDuration)

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_11 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_6) / var_115_11

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_6 + var_115_11 and arg_112_1.time_ < var_115_6 + var_115_11 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play939021029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 939021029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play939021030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1211ui_story"]) and arg_116_1.var_.characterEffect1211ui_story == nil then
				arg_116_1.var_.characterEffect1211ui_story = arg_116_1.actors_["1211ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1211ui_story"]) then
				if arg_116_1.var_.characterEffect1211ui_story and not isNil(arg_116_1.actors_["1211ui_story"]) then
					arg_116_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_0)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1211ui_story"]) and arg_116_1.var_.characterEffect1211ui_story then
				arg_116_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			local var_119_1 = 0
			local var_119_2 = 0.75

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_3 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(939021029).content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 30 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 30)

				if (30 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 30)) > 0 and var_119_2 < var_119_5 then
					arg_116_1.talkMaxDuration = var_119_5

					if var_119_5 + var_119_1 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + var_119_1
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_6 = math.max(var_119_2, arg_116_1.talkMaxDuration)

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_6 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_1) / var_119_6

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_1 + var_119_6 and arg_116_1.time_ < var_119_1 + var_119_6 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play939021030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 939021030
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play939021031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos1211ui_story = arg_120_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_123_0 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 then
				arg_120_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_120_1.time_ - 0) / var_123_0)
				arg_120_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1211ui_story"].transform.position).z)
				arg_120_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["1211ui_story"].transform.localEulerAngles = arg_120_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 then
				arg_120_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_120_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["1211ui_story"].transform.position).z)
				arg_120_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["1211ui_story"].transform.localEulerAngles = arg_120_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_123_1 = arg_120_1.actors_["1284ui_story"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos1284ui_story = var_123_1.localPosition
			end

			local var_123_2 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_2 then
				var_123_1.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_120_1.time_ - 0) / var_123_2)
				var_123_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_1.position).x, (manager.ui.mainCamera.transform.position - var_123_1.position).y, (manager.ui.mainCamera.transform.position - var_123_1.position).z)
				var_123_1.localEulerAngles.z = 0
				var_123_1.localEulerAngles.x = 0
				var_123_1.localEulerAngles = var_123_1.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_2 and arg_120_1.time_ < 0 + var_123_2 + arg_123_0 then
				var_123_1.localPosition = Vector3.New(0, 100, 0)
				var_123_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_1.position).x, (manager.ui.mainCamera.transform.position - var_123_1.position).y, (manager.ui.mainCamera.transform.position - var_123_1.position).z)
				var_123_1.localEulerAngles.z = 0
				var_123_1.localEulerAngles.x = 0
				var_123_1.localEulerAngles = var_123_1.localEulerAngles
			end

			local var_123_3 = arg_120_1.actors_["6148ui_story"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos6148ui_story = var_123_3.localPosition

				local var_123_4 = GameObjectTools.GetOrAddComponent(var_123_3.gameObject, typeof(DynamicBoneHelper))

				if var_123_4 then
					var_123_4:EnableDynamicBone(false)
				end
			end

			local var_123_5 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_5 then
				var_123_3.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_120_1.time_ - 0) / var_123_5)
				var_123_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_3.position).x, (manager.ui.mainCamera.transform.position - var_123_3.position).y, (manager.ui.mainCamera.transform.position - var_123_3.position).z)
				var_123_3.localEulerAngles.z = 0
				var_123_3.localEulerAngles.x = 0
				var_123_3.localEulerAngles = var_123_3.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_5 and arg_120_1.time_ < 0 + var_123_5 + arg_123_0 then
				var_123_3.localPosition = Vector3.New(0, -0.985, -6)
				var_123_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_3.position).x, (manager.ui.mainCamera.transform.position - var_123_3.position).y, (manager.ui.mainCamera.transform.position - var_123_3.position).z)
				var_123_3.localEulerAngles.z = 0
				var_123_3.localEulerAngles.x = 0
				var_123_3.localEulerAngles = var_123_3.localEulerAngles

				local var_123_6 = GameObjectTools.GetOrAddComponent(var_123_3.gameObject, typeof(DynamicBoneHelper))

				if var_123_6 then
					var_123_6:EnableDynamicBone(true)
				end
			end

			local var_123_7 = arg_120_1.actors_["6148ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_7) and arg_120_1.var_.characterEffect6148ui_story == nil then
				arg_120_1.var_.characterEffect6148ui_story = var_123_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_8 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_8 and not isNil(var_123_7) then
				if arg_120_1.var_.characterEffect6148ui_story and not isNil(var_123_7) then
					arg_120_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_8 and arg_120_1.time_ < 0 + var_123_8 + arg_123_0 and not isNil(var_123_7) and arg_120_1.var_.characterEffect6148ui_story then
				arg_120_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_1")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_123_10 = 0
			local var_123_11 = 0.475

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_12 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(939021030).content)

				arg_120_1.text_.text = var_123_12

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_14 = 19 <= 0 and var_123_11 or var_123_11 * (utf8.len(var_123_12) / 19)

				if (19 <= 0 and var_123_11 or var_123_11 * (utf8.len(var_123_12) / 19)) > 0 and var_123_11 < var_123_14 then
					arg_120_1.talkMaxDuration = var_123_14

					if var_123_14 + var_123_10 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_14 + var_123_10
					end
				end

				arg_120_1.text_.text = var_123_12
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_15 = math.max(var_123_11, arg_120_1.talkMaxDuration)

			if var_123_10 <= arg_120_1.time_ and arg_120_1.time_ < var_123_10 + var_123_15 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_10) / var_123_15

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_10 + var_123_15 and arg_120_1.time_ < var_123_10 + var_123_15 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play939021031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 939021031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play939021032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos6148ui_story = arg_124_1.actors_["6148ui_story"].transform.localPosition

				local var_127_0 = GameObjectTools.GetOrAddComponent(arg_124_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_127_0 then
					var_127_0:EnableDynamicBone(false)
				end
			end

			local var_127_1 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_1 then
				arg_124_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_124_1.time_ - 0) / var_127_1)
				arg_124_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["6148ui_story"].transform.position).z)
				arg_124_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["6148ui_story"].transform.localEulerAngles = arg_124_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_1 and arg_124_1.time_ < 0 + var_127_1 + arg_127_0 then
				arg_124_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_124_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_124_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_124_1.actors_["6148ui_story"].transform.position).z)
				arg_124_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_124_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_124_1.actors_["6148ui_story"].transform.localEulerAngles = arg_124_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_127_2 = GameObjectTools.GetOrAddComponent(arg_124_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_127_2 then
					var_127_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action7_2")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_127_3 = 0
			local var_127_4 = 0.575

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_3 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_5 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(939021031).content)

				arg_124_1.text_.text = var_127_5

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_7 = 23 <= 0 and var_127_4 or var_127_4 * (utf8.len(var_127_5) / 23)

				if (23 <= 0 and var_127_4 or var_127_4 * (utf8.len(var_127_5) / 23)) > 0 and var_127_4 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_3 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_3
					end
				end

				arg_124_1.text_.text = var_127_5
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_8 = math.max(var_127_4, arg_124_1.talkMaxDuration)

			if var_127_3 <= arg_124_1.time_ and arg_124_1.time_ < var_127_3 + var_127_8 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_3) / var_127_8

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_3 + var_127_8 and arg_124_1.time_ < var_127_3 + var_127_8 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play939021032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 939021032
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play939021033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1054ui_story = arg_128_1.actors_["1054ui_story"].transform.localPosition

				local var_131_0 = GameObjectTools.GetOrAddComponent(arg_128_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_131_0 then
					var_131_0:EnableDynamicBone(false)
				end
			end

			local var_131_1 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_1 then
				arg_128_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_128_1.time_ - 0) / var_131_1)
				arg_128_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1054ui_story"].transform.position).z)
				arg_128_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1054ui_story"].transform.localEulerAngles = arg_128_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_1 and arg_128_1.time_ < 0 + var_131_1 + arg_131_0 then
				arg_128_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_128_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1054ui_story"].transform.position).z)
				arg_128_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1054ui_story"].transform.localEulerAngles = arg_128_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_131_2 = GameObjectTools.GetOrAddComponent(arg_128_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_131_2 then
					var_131_2:EnableDynamicBone(true)
				end
			end

			local var_131_3 = arg_128_1.actors_["6148ui_story"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos6148ui_story = var_131_3.localPosition

				local var_131_4 = GameObjectTools.GetOrAddComponent(var_131_3.gameObject, typeof(DynamicBoneHelper))

				if var_131_4 then
					var_131_4:EnableDynamicBone(false)
				end
			end

			local var_131_5 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_5 then
				var_131_3.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_128_1.time_ - 0) / var_131_5)
				var_131_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_3.position).x, (manager.ui.mainCamera.transform.position - var_131_3.position).y, (manager.ui.mainCamera.transform.position - var_131_3.position).z)
				var_131_3.localEulerAngles.z = 0
				var_131_3.localEulerAngles.x = 0
				var_131_3.localEulerAngles = var_131_3.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_5 and arg_128_1.time_ < 0 + var_131_5 + arg_131_0 then
				var_131_3.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_131_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_3.position).x, (manager.ui.mainCamera.transform.position - var_131_3.position).y, (manager.ui.mainCamera.transform.position - var_131_3.position).z)
				var_131_3.localEulerAngles.z = 0
				var_131_3.localEulerAngles.x = 0
				var_131_3.localEulerAngles = var_131_3.localEulerAngles

				local var_131_6 = GameObjectTools.GetOrAddComponent(var_131_3.gameObject, typeof(DynamicBoneHelper))

				if var_131_6 then
					var_131_6:EnableDynamicBone(true)
				end
			end

			local var_131_7 = arg_128_1.actors_["1054ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_7) and arg_128_1.var_.characterEffect1054ui_story == nil then
				arg_128_1.var_.characterEffect1054ui_story = var_131_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_8 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_8 and not isNil(var_131_7) then
				if arg_128_1.var_.characterEffect1054ui_story and not isNil(var_131_7) then
					arg_128_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_8 and arg_128_1.time_ < 0 + var_131_8 + arg_131_0 and not isNil(var_131_7) and arg_128_1.var_.characterEffect1054ui_story then
				arg_128_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_131_10 = arg_128_1.actors_["6148ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_10) and arg_128_1.var_.characterEffect6148ui_story == nil then
				arg_128_1.var_.characterEffect6148ui_story = var_131_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_11 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_11 and not isNil(var_131_10) then
				if arg_128_1.var_.characterEffect6148ui_story and not isNil(var_131_10) then
					arg_128_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_128_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_11)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_11 and arg_128_1.time_ < 0 + var_131_11 + arg_131_0 and not isNil(var_131_10) and arg_128_1.var_.characterEffect6148ui_story then
				arg_128_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_128_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_131_12 = 0
			local var_131_13 = 0.525

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_12 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_14 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(939021032).content)

				arg_128_1.text_.text = var_131_14

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_16 = 21 <= 0 and var_131_13 or var_131_13 * (utf8.len(var_131_14) / 21)

				if (21 <= 0 and var_131_13 or var_131_13 * (utf8.len(var_131_14) / 21)) > 0 and var_131_13 < var_131_16 then
					arg_128_1.talkMaxDuration = var_131_16

					if var_131_16 + var_131_12 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_16 + var_131_12
					end
				end

				arg_128_1.text_.text = var_131_14
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_17 = math.max(var_131_13, arg_128_1.talkMaxDuration)

			if var_131_12 <= arg_128_1.time_ and arg_128_1.time_ < var_131_12 + var_131_17 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_12) / var_131_17

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_12 + var_131_17 and arg_128_1.time_ < var_131_12 + var_131_17 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play939021033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 939021033
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play939021034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1054ui_story = arg_132_1.actors_["1054ui_story"].transform.localPosition

				local var_135_0 = GameObjectTools.GetOrAddComponent(arg_132_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_135_0 then
					var_135_0:EnableDynamicBone(false)
				end
			end

			local var_135_1 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_1 then
				arg_132_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_132_1.time_ - 0) / var_135_1)
				arg_132_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1054ui_story"].transform.position).z)
				arg_132_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1054ui_story"].transform.localEulerAngles = arg_132_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_1 and arg_132_1.time_ < 0 + var_135_1 + arg_135_0 then
				arg_132_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_132_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1054ui_story"].transform.position).z)
				arg_132_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1054ui_story"].transform.localEulerAngles = arg_132_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_135_2 = GameObjectTools.GetOrAddComponent(arg_132_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_135_2 then
					var_135_2:EnableDynamicBone(true)
				end
			end

			local var_135_3 = arg_132_1.actors_["6148ui_story"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos6148ui_story = var_135_3.localPosition

				local var_135_4 = GameObjectTools.GetOrAddComponent(var_135_3.gameObject, typeof(DynamicBoneHelper))

				if var_135_4 then
					var_135_4:EnableDynamicBone(false)
				end
			end

			local var_135_5 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_5 then
				var_135_3.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_132_1.time_ - 0) / var_135_5)
				var_135_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_3.position).x, (manager.ui.mainCamera.transform.position - var_135_3.position).y, (manager.ui.mainCamera.transform.position - var_135_3.position).z)
				var_135_3.localEulerAngles.z = 0
				var_135_3.localEulerAngles.x = 0
				var_135_3.localEulerAngles = var_135_3.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_5 and arg_132_1.time_ < 0 + var_135_5 + arg_135_0 then
				var_135_3.localPosition = Vector3.New(0, 100, 0)
				var_135_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_3.position).x, (manager.ui.mainCamera.transform.position - var_135_3.position).y, (manager.ui.mainCamera.transform.position - var_135_3.position).z)
				var_135_3.localEulerAngles.z = 0
				var_135_3.localEulerAngles.x = 0
				var_135_3.localEulerAngles = var_135_3.localEulerAngles

				local var_135_6 = GameObjectTools.GetOrAddComponent(var_135_3.gameObject, typeof(DynamicBoneHelper))

				if var_135_6 then
					var_135_6:EnableDynamicBone(true)
				end
			end

			local var_135_7 = arg_132_1.actors_["1054ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_7) and arg_132_1.var_.characterEffect1054ui_story == nil then
				arg_132_1.var_.characterEffect1054ui_story = var_135_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_8 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_8 and not isNil(var_135_7) then
				if arg_132_1.var_.characterEffect1054ui_story and not isNil(var_135_7) then
					arg_132_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_8)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_8 and arg_132_1.time_ < 0 + var_135_8 + arg_135_0 and not isNil(var_135_7) and arg_132_1.var_.characterEffect1054ui_story then
				arg_132_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_135_9 = 0
			local var_135_10 = 0.775

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_9 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_11 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(939021033).content)

				arg_132_1.text_.text = var_135_11

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_13 = 31 <= 0 and var_135_10 or var_135_10 * (utf8.len(var_135_11) / 31)

				if (31 <= 0 and var_135_10 or var_135_10 * (utf8.len(var_135_11) / 31)) > 0 and var_135_10 < var_135_13 then
					arg_132_1.talkMaxDuration = var_135_13

					if var_135_13 + var_135_9 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_9
					end
				end

				arg_132_1.text_.text = var_135_11
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_14 = math.max(var_135_10, arg_132_1.talkMaxDuration)

			if var_135_9 <= arg_132_1.time_ and arg_132_1.time_ < var_135_9 + var_135_14 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_9) / var_135_14

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_9 + var_135_14 and arg_132_1.time_ < var_135_9 + var_135_14 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play939021034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 939021034
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play939021035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos6148ui_story = arg_136_1.actors_["6148ui_story"].transform.localPosition

				local var_139_0 = GameObjectTools.GetOrAddComponent(arg_136_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_139_0 then
					var_139_0:EnableDynamicBone(false)
				end
			end

			local var_139_1 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_1 then
				arg_136_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_136_1.time_ - 0) / var_139_1)
				arg_136_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["6148ui_story"].transform.position).z)
				arg_136_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["6148ui_story"].transform.localEulerAngles = arg_136_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_1 and arg_136_1.time_ < 0 + var_139_1 + arg_139_0 then
				arg_136_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_136_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["6148ui_story"].transform.position).z)
				arg_136_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["6148ui_story"].transform.localEulerAngles = arg_136_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_139_2 = GameObjectTools.GetOrAddComponent(arg_136_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_139_2 then
					var_139_2:EnableDynamicBone(true)
				end
			end

			local var_139_3 = arg_136_1.actors_["6148ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_3) and arg_136_1.var_.characterEffect6148ui_story == nil then
				arg_136_1.var_.characterEffect6148ui_story = var_139_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_4 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_4 and not isNil(var_139_3) then
				if arg_136_1.var_.characterEffect6148ui_story and not isNil(var_139_3) then
					arg_136_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_4 and arg_136_1.time_ < 0 + var_139_4 + arg_139_0 and not isNil(var_139_3) and arg_136_1.var_.characterEffect6148ui_story then
				arg_136_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_139_6 = 0
			local var_139_7 = 1.2

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_8 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(939021034).content)

				arg_136_1.text_.text = var_139_8

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_10 = 48 <= 0 and var_139_7 or var_139_7 * (utf8.len(var_139_8) / 48)

				if (48 <= 0 and var_139_7 or var_139_7 * (utf8.len(var_139_8) / 48)) > 0 and var_139_7 < var_139_10 then
					arg_136_1.talkMaxDuration = var_139_10

					if var_139_10 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_6
					end
				end

				arg_136_1.text_.text = var_139_8
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_11 = math.max(var_139_7, arg_136_1.talkMaxDuration)

			if var_139_6 <= arg_136_1.time_ and arg_136_1.time_ < var_139_6 + var_139_11 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_6) / var_139_11

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_6 + var_139_11 and arg_136_1.time_ < var_139_6 + var_139_11 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play939021035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 939021035
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play939021036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1054ui_story = arg_140_1.actors_["1054ui_story"].transform.localPosition

				local var_143_0 = GameObjectTools.GetOrAddComponent(arg_140_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_143_0 then
					var_143_0:EnableDynamicBone(false)
				end
			end

			local var_143_1 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_1 then
				arg_140_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_140_1.time_ - 0) / var_143_1)
				arg_140_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1054ui_story"].transform.position).z)
				arg_140_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1054ui_story"].transform.localEulerAngles = arg_140_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_1 and arg_140_1.time_ < 0 + var_143_1 + arg_143_0 then
				arg_140_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_140_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1054ui_story"].transform.position).z)
				arg_140_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1054ui_story"].transform.localEulerAngles = arg_140_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_143_2 = GameObjectTools.GetOrAddComponent(arg_140_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_143_2 then
					var_143_2:EnableDynamicBone(true)
				end
			end

			local var_143_3 = arg_140_1.actors_["1054ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_3) and arg_140_1.var_.characterEffect1054ui_story == nil then
				arg_140_1.var_.characterEffect1054ui_story = var_143_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_4 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 and not isNil(var_143_3) then
				if arg_140_1.var_.characterEffect1054ui_story and not isNil(var_143_3) then
					arg_140_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 and not isNil(var_143_3) and arg_140_1.var_.characterEffect1054ui_story then
				arg_140_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_143_6 = arg_140_1.actors_["6148ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_6) and arg_140_1.var_.characterEffect6148ui_story == nil then
				arg_140_1.var_.characterEffect6148ui_story = var_143_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_7 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_7 and not isNil(var_143_6) then
				if arg_140_1.var_.characterEffect6148ui_story and not isNil(var_143_6) then
					arg_140_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_140_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_7)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_7 and arg_140_1.time_ < 0 + var_143_7 + arg_143_0 and not isNil(var_143_6) and arg_140_1.var_.characterEffect6148ui_story then
				arg_140_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_140_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_143_8 = 0
			local var_143_9 = 0.4

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_8 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_10 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(939021035).content)

				arg_140_1.text_.text = var_143_10

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_12 = 16 <= 0 and var_143_9 or var_143_9 * (utf8.len(var_143_10) / 16)

				if (16 <= 0 and var_143_9 or var_143_9 * (utf8.len(var_143_10) / 16)) > 0 and var_143_9 < var_143_12 then
					arg_140_1.talkMaxDuration = var_143_12

					if var_143_12 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_12 + var_143_8
					end
				end

				arg_140_1.text_.text = var_143_10
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_13 = math.max(var_143_9, arg_140_1.talkMaxDuration)

			if var_143_8 <= arg_140_1.time_ and arg_140_1.time_ < var_143_8 + var_143_13 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_8) / var_143_13

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_8 + var_143_13 and arg_140_1.time_ < var_143_8 + var_143_13 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play939021036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 939021036
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play939021037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1054ui_story"]) and arg_144_1.var_.characterEffect1054ui_story == nil then
				arg_144_1.var_.characterEffect1054ui_story = arg_144_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1054ui_story"]) then
				if arg_144_1.var_.characterEffect1054ui_story and not isNil(arg_144_1.actors_["1054ui_story"]) then
					arg_144_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_0)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1054ui_story"]) and arg_144_1.var_.characterEffect1054ui_story then
				arg_144_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_147_1 = 0
			local var_147_2 = 1.025

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_3 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(939021036).content)

				arg_144_1.text_.text = var_147_3

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 41 <= 0 and var_147_2 or var_147_2 * (utf8.len(var_147_3) / 41)

				if (41 <= 0 and var_147_2 or var_147_2 * (utf8.len(var_147_3) / 41)) > 0 and var_147_2 < var_147_5 then
					arg_144_1.talkMaxDuration = var_147_5

					if var_147_5 + var_147_1 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + var_147_1
					end
				end

				arg_144_1.text_.text = var_147_3
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_6 = math.max(var_147_2, arg_144_1.talkMaxDuration)

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_6 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_1) / var_147_6

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_1 + var_147_6 and arg_144_1.time_ < var_147_1 + var_147_6 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play939021037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 939021037
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play939021038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0.65

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_1 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(939021037).content)

				arg_148_1.text_.text = var_151_1

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_3 = 26 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_1) / 26)

				if (26 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_1) / 26)) > 0 and var_151_0 < var_151_3 then
					arg_148_1.talkMaxDuration = var_151_3

					if var_151_3 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_3 + 0
					end
				end

				arg_148_1.text_.text = var_151_1
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_4 = math.max(var_151_0, arg_148_1.talkMaxDuration)

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_4 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - 0) / var_151_4

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= 0 + var_151_4 and arg_148_1.time_ < 0 + var_151_4 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play939021038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 939021038
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play939021039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos6148ui_story = arg_152_1.actors_["6148ui_story"].transform.localPosition

				local var_155_0 = GameObjectTools.GetOrAddComponent(arg_152_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_155_0 then
					var_155_0:EnableDynamicBone(false)
				end
			end

			local var_155_1 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_1 then
				arg_152_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_152_1.time_ - 0) / var_155_1)
				arg_152_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["6148ui_story"].transform.position).z)
				arg_152_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["6148ui_story"].transform.localEulerAngles = arg_152_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_1 and arg_152_1.time_ < 0 + var_155_1 + arg_155_0 then
				arg_152_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_152_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["6148ui_story"].transform.position).z)
				arg_152_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["6148ui_story"].transform.localEulerAngles = arg_152_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_155_2 = GameObjectTools.GetOrAddComponent(arg_152_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_155_2 then
					var_155_2:EnableDynamicBone(true)
				end
			end

			local var_155_3 = arg_152_1.actors_["6148ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_3) and arg_152_1.var_.characterEffect6148ui_story == nil then
				arg_152_1.var_.characterEffect6148ui_story = var_155_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_4 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_4 and not isNil(var_155_3) then
				if arg_152_1.var_.characterEffect6148ui_story and not isNil(var_155_3) then
					arg_152_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_4 and arg_152_1.time_ < 0 + var_155_4 + arg_155_0 and not isNil(var_155_3) and arg_152_1.var_.characterEffect6148ui_story then
				arg_152_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_155_6 = 0
			local var_155_7 = 0.775

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_6 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_8 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(939021038).content)

				arg_152_1.text_.text = var_155_8

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_10 = 31 <= 0 and var_155_7 or var_155_7 * (utf8.len(var_155_8) / 31)

				if (31 <= 0 and var_155_7 or var_155_7 * (utf8.len(var_155_8) / 31)) > 0 and var_155_7 < var_155_10 then
					arg_152_1.talkMaxDuration = var_155_10

					if var_155_10 + var_155_6 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_6
					end
				end

				arg_152_1.text_.text = var_155_8
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_11 = math.max(var_155_7, arg_152_1.talkMaxDuration)

			if var_155_6 <= arg_152_1.time_ and arg_152_1.time_ < var_155_6 + var_155_11 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_6) / var_155_11

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_6 + var_155_11 and arg_152_1.time_ < var_155_6 + var_155_11 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play939021039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 939021039
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play939021040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos6148ui_story = arg_156_1.actors_["6148ui_story"].transform.localPosition

				local var_159_0 = GameObjectTools.GetOrAddComponent(arg_156_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_159_0 then
					var_159_0:EnableDynamicBone(false)
				end
			end

			local var_159_1 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_1 then
				arg_156_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_156_1.time_ - 0) / var_159_1)
				arg_156_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["6148ui_story"].transform.position).z)
				arg_156_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["6148ui_story"].transform.localEulerAngles = arg_156_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_1 and arg_156_1.time_ < 0 + var_159_1 + arg_159_0 then
				arg_156_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_156_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["6148ui_story"].transform.position).z)
				arg_156_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["6148ui_story"].transform.localEulerAngles = arg_156_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_159_2 = GameObjectTools.GetOrAddComponent(arg_156_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_159_2 then
					var_159_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_159_3 = 0
			local var_159_4 = 0.575

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_3 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_5 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(939021039).content)

				arg_156_1.text_.text = var_159_5

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_7 = 23 <= 0 and var_159_4 or var_159_4 * (utf8.len(var_159_5) / 23)

				if (23 <= 0 and var_159_4 or var_159_4 * (utf8.len(var_159_5) / 23)) > 0 and var_159_4 < var_159_7 then
					arg_156_1.talkMaxDuration = var_159_7

					if var_159_7 + var_159_3 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_7 + var_159_3
					end
				end

				arg_156_1.text_.text = var_159_5
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_8 = math.max(var_159_4, arg_156_1.talkMaxDuration)

			if var_159_3 <= arg_156_1.time_ and arg_156_1.time_ < var_159_3 + var_159_8 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_3) / var_159_8

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_3 + var_159_8 and arg_156_1.time_ < var_159_3 + var_159_8 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play939021040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 939021040
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
			arg_160_1.auto_ = false
		end

		function arg_160_1.playNext_(arg_162_0)
			arg_160_1.onStoryFinished_()
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1054ui_story = arg_160_1.actors_["1054ui_story"].transform.localPosition

				local var_163_0 = GameObjectTools.GetOrAddComponent(arg_160_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_163_0 then
					var_163_0:EnableDynamicBone(false)
				end
			end

			local var_163_1 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_1 then
				arg_160_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_160_1.time_ - 0) / var_163_1)
				arg_160_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1054ui_story"].transform.position).z)
				arg_160_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1054ui_story"].transform.localEulerAngles = arg_160_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_1 and arg_160_1.time_ < 0 + var_163_1 + arg_163_0 then
				arg_160_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_160_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1054ui_story"].transform.position).z)
				arg_160_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1054ui_story"].transform.localEulerAngles = arg_160_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_163_2 = GameObjectTools.GetOrAddComponent(arg_160_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_163_2 then
					var_163_2:EnableDynamicBone(true)
				end
			end

			local var_163_3 = arg_160_1.actors_["1054ui_story"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_3) and arg_160_1.var_.characterEffect1054ui_story == nil then
				arg_160_1.var_.characterEffect1054ui_story = var_163_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_4 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_4 and not isNil(var_163_3) then
				if arg_160_1.var_.characterEffect1054ui_story and not isNil(var_163_3) then
					arg_160_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_4 and arg_160_1.time_ < 0 + var_163_4 + arg_163_0 and not isNil(var_163_3) and arg_160_1.var_.characterEffect1054ui_story then
				arg_160_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_163_6 = arg_160_1.actors_["6148ui_story"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_6) and arg_160_1.var_.characterEffect6148ui_story == nil then
				arg_160_1.var_.characterEffect6148ui_story = var_163_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_7 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_7 and not isNil(var_163_6) then
				if arg_160_1.var_.characterEffect6148ui_story and not isNil(var_163_6) then
					arg_160_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_160_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_160_1.time_ - 0) / var_163_7)
				end
			end

			if arg_160_1.time_ >= 0 + var_163_7 and arg_160_1.time_ < 0 + var_163_7 + arg_163_0 and not isNil(var_163_6) and arg_160_1.var_.characterEffect6148ui_story then
				arg_160_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_160_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054actionlink/1054action454")
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_163_8 = 0
			local var_163_9 = 0.375

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_8 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_10 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(939021040).content)

				arg_160_1.text_.text = var_163_10

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_12 = 15 <= 0 and var_163_9 or var_163_9 * (utf8.len(var_163_10) / 15)

				if (15 <= 0 and var_163_9 or var_163_9 * (utf8.len(var_163_10) / 15)) > 0 and var_163_9 < var_163_12 then
					arg_160_1.talkMaxDuration = var_163_12

					if var_163_12 + var_163_8 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_12 + var_163_8
					end
				end

				arg_160_1.text_.text = var_163_10
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_13 = math.max(var_163_9, arg_160_1.talkMaxDuration)

			if var_163_8 <= arg_160_1.time_ and arg_160_1.time_ < var_163_8 + var_163_13 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_8) / var_163_13

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_8 + var_163_13 and arg_160_1.time_ < var_163_8 + var_163_13 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST15a"
	},
	voices = {},
	skipMarkers = {
		939021001
	}
}
