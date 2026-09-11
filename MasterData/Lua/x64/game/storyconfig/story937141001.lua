return {
	Play937141001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 937141001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play937141002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.H03a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H03a")
				var_4_0.name = "H03a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.H03a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.H03a

				arg_1_1.bgs_.H03a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "H03a" then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			if 1.2 < arg_1_1.time_ and arg_1_1.time_ <= 1.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_8_minigame_valentine", "bgm_activity_2_8_minigame_valentine", "bgm_activity_2_8_minigame_valentine.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_2_8_minigame_valentine", "bgm_activity_2_8_minigame_valentine")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 0.2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(937141001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 8 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 8)

				if (8 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 8)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play937141002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 937141002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play937141003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1194ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1194ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1194ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1194ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1194ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1194ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1194ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1194ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1194ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1194ui_story = var_12_3.localPosition

				local var_12_4 = GameObjectTools.GetOrAddComponent(var_12_3.gameObject, typeof(DynamicBoneHelper))

				if var_12_4 then
					var_12_4:EnableDynamicBone(false)
				end
			end

			local var_12_5 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_5 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1194ui_story, Vector3.New(0, -0.88, -6.08), (arg_9_1.time_ - 0) / var_12_5)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_5 and arg_9_1.time_ < 0 + var_12_5 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0, -0.88, -6.08)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles

				local var_12_6 = GameObjectTools.GetOrAddComponent(var_12_3.gameObject, typeof(DynamicBoneHelper))

				if var_12_6 then
					var_12_6:EnableDynamicBone(true)
				end
			end

			local var_12_7 = arg_9_1.actors_["1194ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.characterEffect1194ui_story == nil then
				arg_9_1.var_.characterEffect1194ui_story = var_12_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_8 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_8 and not isNil(var_12_7) then
				if arg_9_1.var_.characterEffect1194ui_story and not isNil(var_12_7) then
					arg_9_1.var_.characterEffect1194ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_8 and arg_9_1.time_ < 0 + var_12_8 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.characterEffect1194ui_story then
				arg_9_1.var_.characterEffect1194ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1194ui_story", "StoryTimeline/CharAction/story1194/story1194action/1194action2_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1194ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_12_10 = 0
			local var_12_11 = 0.2

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_12 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(937141002).content)

				arg_9_1.text_.text = var_12_12

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_14 = 8 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_12) / 8)

				if (8 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_12) / 8)) > 0 and var_12_11 < var_12_14 then
					arg_9_1.talkMaxDuration = var_12_14

					if var_12_14 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_12
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_15 = math.max(var_12_11, arg_9_1.talkMaxDuration)

			if var_12_10 <= arg_9_1.time_ and arg_9_1.time_ < var_12_10 + var_12_15 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_10) / var_12_15

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_10 + var_12_15 and arg_9_1.time_ < var_12_10 + var_12_15 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play937141003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 937141003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play937141004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1194ui_story"]) and arg_13_1.var_.characterEffect1194ui_story == nil then
				arg_13_1.var_.characterEffect1194ui_story = arg_13_1.actors_["1194ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1194ui_story"]) then
				if arg_13_1.var_.characterEffect1194ui_story and not isNil(arg_13_1.actors_["1194ui_story"]) then
					arg_13_1.var_.characterEffect1194ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1194ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1194ui_story"]) and arg_13_1.var_.characterEffect1194ui_story then
				arg_13_1.var_.characterEffect1194ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1194ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 0.475

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(937141003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 19 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 19)

				if (19 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 19)) > 0 and var_16_2 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_6 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_6 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_6

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_6 and arg_13_1.time_ < var_16_1 + var_16_6 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play937141004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 937141004
		arg_17_1.duration_ = 5.47

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play937141005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_9000

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1194ui_story = arg_17_1.actors_["1194ui_story"].transform.localPosition

				local var_20_0 = GameObjectTools.GetOrAddComponent(arg_17_1.actors_["1194ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_20_0 then
					var_20_0:EnableDynamicBone(false)
				end
			end

			local var_20_1 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 then
				arg_17_1.actors_["1194ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1194ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_1)
				arg_17_1.actors_["1194ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1194ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1194ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1194ui_story"].transform.position).z)
				arg_17_1.actors_["1194ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1194ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1194ui_story"].transform.localEulerAngles = arg_17_1.actors_["1194ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 then
				arg_17_1.actors_["1194ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1194ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1194ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1194ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1194ui_story"].transform.position).z)
				arg_17_1.actors_["1194ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1194ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1194ui_story"].transform.localEulerAngles = arg_17_1.actors_["1194ui_story"].transform.localEulerAngles

				local var_20_2 = GameObjectTools.GetOrAddComponent(arg_17_1.actors_["1194ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(true)
				end
			end

			local var_20_3 = 0

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_3 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = false

				arg_17_1:SetGaussion(false)
			end

			local var_20_4 = 0.0333333333333333

			if var_20_3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_3 + var_20_4 then
				local var_20_5 = Color.New(1, 1, 1)

				var_20_5.a = Mathf.Lerp(1, 0, (arg_17_1.time_ - var_20_3) / var_20_4)
				arg_17_1.mask_.color = var_20_5
			end

			if arg_17_1.time_ >= var_20_3 + var_20_4 and arg_17_1.time_ < var_20_3 + var_20_4 + arg_20_0 then
				local var_20_6 = Color.New(1, 1, 1)

				arg_17_1.mask_.enabled = false
				var_20_6.a = 0
				arg_17_1.mask_.color = var_20_6
			end

			local var_20_7 = 0.0666666666666667

			if 0.0666666666666667 < arg_17_1.time_ and arg_17_1.time_ <= var_20_7 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = false

				arg_17_1:SetGaussion(false)
			end

			local var_20_8 = 0.1

			if var_20_7 <= arg_17_1.time_ and arg_17_1.time_ < var_20_7 + var_20_8 then
				local var_20_9 = Color.New(1, 1, 1)

				var_20_9.a = Mathf.Lerp(1, 0, (arg_17_1.time_ - var_20_7) / var_20_8)
				arg_17_1.mask_.color = var_20_9
			end

			if arg_17_1.time_ >= var_20_7 + var_20_8 and arg_17_1.time_ < var_20_7 + var_20_8 + arg_20_0 then
				local var_20_10 = Color.New(1, 1, 1)

				arg_17_1.mask_.enabled = false
				var_20_10.a = 0
				arg_17_1.mask_.color = var_20_10
			end

			local var_20_11 = 0.166666666666667

			if 0.166666666666667 < arg_17_1.time_ and arg_17_1.time_ <= var_20_11 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = false

				arg_17_1:SetGaussion(false)
			end

			local var_20_12 = 0.0999999999999999

			if var_20_11 <= arg_17_1.time_ and arg_17_1.time_ < var_20_11 + var_20_12 then
				local var_20_13 = Color.New(1, 1, 1)

				var_20_13.a = Mathf.Lerp(1, 0, (arg_17_1.time_ - var_20_11) / var_20_12)
				arg_17_1.mask_.color = var_20_13
			end

			if arg_17_1.time_ >= var_20_11 + var_20_12 and arg_17_1.time_ < var_20_11 + var_20_12 + arg_20_0 then
				local var_20_14 = Color.New(1, 1, 1)

				arg_17_1.mask_.enabled = false
				var_20_14.a = 0
				arg_17_1.mask_.color = var_20_14
			end

			local var_20_15 = 0.266666666666667

			if 0.266666666666667 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = false

				arg_17_1:SetGaussion(false)
			end

			local var_20_16 = 0.1

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_16 then
				local var_20_17 = Color.New(1, 1, 1)

				var_20_17.a = Mathf.Lerp(1, 0, (arg_17_1.time_ - var_20_15) / var_20_16)
				arg_17_1.mask_.color = var_20_17
			end

			if arg_17_1.time_ >= var_20_15 + var_20_16 and arg_17_1.time_ < var_20_15 + var_20_16 + arg_20_0 then
				local var_20_18 = Color.New(1, 1, 1)

				arg_17_1.mask_.enabled = false
				var_20_18.a = 0
				arg_17_1.mask_.color = var_20_18
			end

			local var_20_19 = 0.366666666666667

			if 0.366666666666667 < arg_17_1.time_ and arg_17_1.time_ <= var_20_19 + arg_20_0 then
				arg_17_1.mask_.enabled = true
				arg_17_1.mask_.raycastTarget = false

				arg_17_1:SetGaussion(false)
			end

			local var_20_20 = 0.0999999999999999

			if var_20_19 <= arg_17_1.time_ and arg_17_1.time_ < var_20_19 + var_20_20 then
				local var_20_21 = Color.New(1, 1, 1)

				var_20_21.a = Mathf.Lerp(1, 0, (arg_17_1.time_ - var_20_19) / var_20_20)
				arg_17_1.mask_.color = var_20_21
			end

			if arg_17_1.time_ >= var_20_19 + var_20_20 and arg_17_1.time_ < var_20_19 + var_20_20 + arg_20_0 then
				local var_20_22 = Color.New(1, 1, 1)

				arg_17_1.mask_.enabled = false
				var_20_22.a = 0
				arg_17_1.mask_.color = var_20_22
			end

			if 0.166666666666667 < arg_17_1.time_ and arg_17_1.time_ <= 0.166666666666667 + arg_20_0 then
				local var_20_23 = arg_17_1.var_.effecthailaqingrenjiexiayu1

				if not arg_17_1.var_.effecthailaqingrenjiexiayu1 then
					var_20_23 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy"), manager.ui.mainCamera.transform)
					var_20_23.name = "hailaqingrenjiexiayu1"
					arg_17_1.var_.effecthailaqingrenjiexiayu1 = var_20_23
				else
					var_20_23.transform:SetParent(var_20_9000)
				end

				var_20_23.transform.localPosition = Vector3.New(0, 0, 0)
				var_20_23.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_20_25 = 0

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_25 + arg_20_0 then
				arg_17_1.allBtn_.enabled = false
			end

			if arg_17_1.time_ >= var_20_25 + 0.466666666666667 and arg_17_1.time_ < var_20_25 + 0.466666666666667 + arg_20_0 then
				arg_17_1.allBtn_.enabled = true
			end

			if arg_17_1.frameCnt_ <= 1 then
				arg_17_1.dialog_:SetActive(false)
			end

			local var_20_26 = 0.466666666666667
			local var_20_27 = 1.475

			if 0.466666666666667 < arg_17_1.time_ and arg_17_1.time_ <= var_20_26 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0

				arg_17_1.dialog_:SetActive(true)

				arg_17_1.dialogCg_.alpha = 0

				local var_20_28 = LeanTween.value(arg_17_1.dialog_, 0, 1, 0.3)

				var_20_28:setOnUpdate(LuaHelper.FloatAction(function(arg_21_0)
					arg_17_1.dialogCg_.alpha = arg_21_0
				end))
				var_20_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_17_1.dialog_)
					var_20_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_17_1.duration_ = arg_17_1.duration_ + 0.3

				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_29 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(937141004).content)

				arg_17_1.text_.text = var_20_29

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_31 = 59 <= 0 and var_20_27 or var_20_27 * (utf8.len(var_20_29) / 59)

				if (59 <= 0 and var_20_27 or var_20_27 * (utf8.len(var_20_29) / 59)) > 0 and var_20_27 < var_20_31 then
					arg_17_1.talkMaxDuration = var_20_31
					var_20_26 = var_20_26 + 0.3

					if var_20_31 + var_20_26 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_31 + var_20_26
					end
				end

				arg_17_1.text_.text = var_20_29
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_32 = var_20_26 + 0.3
			local var_20_33 = math.max(var_20_27, arg_17_1.talkMaxDuration)

			if var_20_26 + 0.3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_32 + var_20_33 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_32) / var_20_33

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_32 + var_20_33 and arg_17_1.time_ < var_20_32 + var_20_33 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play937141005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 937141005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play937141006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1194ui_story = arg_23_1.actors_["1194ui_story"].transform.localPosition

				local var_26_0 = GameObjectTools.GetOrAddComponent(arg_23_1.actors_["1194ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_26_0 then
					var_26_0:EnableDynamicBone(false)
				end
			end

			local var_26_1 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_1 then
				arg_23_1.actors_["1194ui_story"].transform.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1194ui_story, Vector3.New(0, -0.88, -6.08), (arg_23_1.time_ - 0) / var_26_1)
				arg_23_1.actors_["1194ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["1194ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1194ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1194ui_story"].transform.position).z)
				arg_23_1.actors_["1194ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["1194ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["1194ui_story"].transform.localEulerAngles = arg_23_1.actors_["1194ui_story"].transform.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_1 and arg_23_1.time_ < 0 + var_26_1 + arg_26_0 then
				arg_23_1.actors_["1194ui_story"].transform.localPosition = Vector3.New(0, -0.88, -6.08)
				arg_23_1.actors_["1194ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["1194ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1194ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1194ui_story"].transform.position).z)
				arg_23_1.actors_["1194ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["1194ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["1194ui_story"].transform.localEulerAngles = arg_23_1.actors_["1194ui_story"].transform.localEulerAngles

				local var_26_2 = GameObjectTools.GetOrAddComponent(arg_23_1.actors_["1194ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_26_2 then
					var_26_2:EnableDynamicBone(true)
				end
			end

			local var_26_3 = arg_23_1.actors_["1194ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_3) and arg_23_1.var_.characterEffect1194ui_story == nil then
				arg_23_1.var_.characterEffect1194ui_story = var_26_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_4 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 and not isNil(var_26_3) then
				if arg_23_1.var_.characterEffect1194ui_story and not isNil(var_26_3) then
					arg_23_1.var_.characterEffect1194ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 and not isNil(var_26_3) and arg_23_1.var_.characterEffect1194ui_story then
				arg_23_1.var_.characterEffect1194ui_story.fillFlat = false
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1194ui_story", "StoryTimeline/CharAction/story1194/story1194action/1194action3_1")
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:PlayTimeline("1194ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_26_6 = 0
			local var_26_7 = 0.4

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_8 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(937141005).content)

				arg_23_1.text_.text = var_26_8

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_10 = 16 <= 0 and var_26_7 or var_26_7 * (utf8.len(var_26_8) / 16)

				if (16 <= 0 and var_26_7 or var_26_7 * (utf8.len(var_26_8) / 16)) > 0 and var_26_7 < var_26_10 then
					arg_23_1.talkMaxDuration = var_26_10

					if var_26_10 + var_26_6 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_10 + var_26_6
					end
				end

				arg_23_1.text_.text = var_26_8
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_11 = math.max(var_26_7, arg_23_1.talkMaxDuration)

			if var_26_6 <= arg_23_1.time_ and arg_23_1.time_ < var_26_6 + var_26_11 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_6) / var_26_11

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_6 + var_26_11 and arg_23_1.time_ < var_26_6 + var_26_11 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play937141006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 937141006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play937141007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1194ui_story"]) and arg_27_1.var_.characterEffect1194ui_story == nil then
				arg_27_1.var_.characterEffect1194ui_story = arg_27_1.actors_["1194ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_0 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["1194ui_story"]) then
				if arg_27_1.var_.characterEffect1194ui_story and not isNil(arg_27_1.actors_["1194ui_story"]) then
					arg_27_1.var_.characterEffect1194ui_story.fillFlat = true
					arg_27_1.var_.characterEffect1194ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_27_1.time_ - 0) / var_30_0)
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["1194ui_story"]) and arg_27_1.var_.characterEffect1194ui_story then
				arg_27_1.var_.characterEffect1194ui_story.fillFlat = true
				arg_27_1.var_.characterEffect1194ui_story.fillRatio = 0.5
			end

			local var_30_1 = 0
			local var_30_2 = 0.55

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_3 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(937141006).content)

				arg_27_1.text_.text = var_30_3

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_5 = 22 <= 0 and var_30_2 or var_30_2 * (utf8.len(var_30_3) / 22)

				if (22 <= 0 and var_30_2 or var_30_2 * (utf8.len(var_30_3) / 22)) > 0 and var_30_2 < var_30_5 then
					arg_27_1.talkMaxDuration = var_30_5

					if var_30_5 + var_30_1 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + var_30_1
					end
				end

				arg_27_1.text_.text = var_30_3
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_6 = math.max(var_30_2, arg_27_1.talkMaxDuration)

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_6 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_1) / var_30_6

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_1 + var_30_6 and arg_27_1.time_ < var_30_1 + var_30_6 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play937141007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 937141007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play937141008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1194ui_story = arg_31_1.actors_["1194ui_story"].transform.localPosition

				local var_34_0 = GameObjectTools.GetOrAddComponent(arg_31_1.actors_["1194ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_34_0 then
					var_34_0:EnableDynamicBone(false)
				end
			end

			local var_34_1 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_1 then
				arg_31_1.actors_["1194ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1194ui_story, Vector3.New(0, -0.88, -6.08), (arg_31_1.time_ - 0) / var_34_1)
				arg_31_1.actors_["1194ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1194ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1194ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1194ui_story"].transform.position).z)
				arg_31_1.actors_["1194ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1194ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1194ui_story"].transform.localEulerAngles = arg_31_1.actors_["1194ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_1 and arg_31_1.time_ < 0 + var_34_1 + arg_34_0 then
				arg_31_1.actors_["1194ui_story"].transform.localPosition = Vector3.New(0, -0.88, -6.08)
				arg_31_1.actors_["1194ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1194ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1194ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1194ui_story"].transform.position).z)
				arg_31_1.actors_["1194ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1194ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1194ui_story"].transform.localEulerAngles = arg_31_1.actors_["1194ui_story"].transform.localEulerAngles

				local var_34_2 = GameObjectTools.GetOrAddComponent(arg_31_1.actors_["1194ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_34_2 then
					var_34_2:EnableDynamicBone(true)
				end
			end

			local var_34_3 = arg_31_1.actors_["1194ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_3) and arg_31_1.var_.characterEffect1194ui_story == nil then
				arg_31_1.var_.characterEffect1194ui_story = var_34_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_4 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 and not isNil(var_34_3) then
				if arg_31_1.var_.characterEffect1194ui_story and not isNil(var_34_3) then
					arg_31_1.var_.characterEffect1194ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 and not isNil(var_34_3) and arg_31_1.var_.characterEffect1194ui_story then
				arg_31_1.var_.characterEffect1194ui_story.fillFlat = false
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1194ui_story", "StoryTimeline/CharAction/story1194/story1194action/1194action3_2")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1194ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_34_6 = 0
			local var_34_7 = 0.7

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_6 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_8 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(937141007).content)

				arg_31_1.text_.text = var_34_8

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_10 = 28 <= 0 and var_34_7 or var_34_7 * (utf8.len(var_34_8) / 28)

				if (28 <= 0 and var_34_7 or var_34_7 * (utf8.len(var_34_8) / 28)) > 0 and var_34_7 < var_34_10 then
					arg_31_1.talkMaxDuration = var_34_10

					if var_34_10 + var_34_6 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_10 + var_34_6
					end
				end

				arg_31_1.text_.text = var_34_8
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_11 = math.max(var_34_7, arg_31_1.talkMaxDuration)

			if var_34_6 <= arg_31_1.time_ and arg_31_1.time_ < var_34_6 + var_34_11 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_6) / var_34_11

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_6 + var_34_11 and arg_31_1.time_ < var_34_6 + var_34_11 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play937141008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 937141008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play937141009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1194ui_story = arg_35_1.actors_["1194ui_story"].transform.localPosition

				local var_38_0 = GameObjectTools.GetOrAddComponent(arg_35_1.actors_["1194ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_38_0 then
					var_38_0:EnableDynamicBone(false)
				end
			end

			local var_38_1 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_1 then
				arg_35_1.actors_["1194ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1194ui_story, Vector3.New(0, 100, 0), (arg_35_1.time_ - 0) / var_38_1)
				arg_35_1.actors_["1194ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1194ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1194ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1194ui_story"].transform.position).z)
				arg_35_1.actors_["1194ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1194ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1194ui_story"].transform.localEulerAngles = arg_35_1.actors_["1194ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_1 and arg_35_1.time_ < 0 + var_38_1 + arg_38_0 then
				arg_35_1.actors_["1194ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.actors_["1194ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1194ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1194ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1194ui_story"].transform.position).z)
				arg_35_1.actors_["1194ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1194ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1194ui_story"].transform.localEulerAngles = arg_35_1.actors_["1194ui_story"].transform.localEulerAngles

				local var_38_2 = GameObjectTools.GetOrAddComponent(arg_35_1.actors_["1194ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_38_2 then
					var_38_2:EnableDynamicBone(true)
				end
			end

			local var_38_3 = arg_35_1.actors_["1194ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_3) and arg_35_1.var_.characterEffect1194ui_story == nil then
				arg_35_1.var_.characterEffect1194ui_story = var_38_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_4 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 and not isNil(var_38_3) then
				if arg_35_1.var_.characterEffect1194ui_story and not isNil(var_38_3) then
					arg_35_1.var_.characterEffect1194ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1194ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_4)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 and not isNil(var_38_3) and arg_35_1.var_.characterEffect1194ui_story then
				arg_35_1.var_.characterEffect1194ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1194ui_story.fillRatio = 0.5
			end

			local var_38_5 = 0
			local var_38_6 = 1.225

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_5 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_7 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(937141008).content)

				arg_35_1.text_.text = var_38_7

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_9 = 49 <= 0 and var_38_6 or var_38_6 * (utf8.len(var_38_7) / 49)

				if (49 <= 0 and var_38_6 or var_38_6 * (utf8.len(var_38_7) / 49)) > 0 and var_38_6 < var_38_9 then
					arg_35_1.talkMaxDuration = var_38_9

					if var_38_9 + var_38_5 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_9 + var_38_5
					end
				end

				arg_35_1.text_.text = var_38_7
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_10 = math.max(var_38_6, arg_35_1.talkMaxDuration)

			if var_38_5 <= arg_35_1.time_ and arg_35_1.time_ < var_38_5 + var_38_10 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_5) / var_38_10

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_5 + var_38_10 and arg_35_1.time_ < var_38_5 + var_38_10 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play937141009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 937141009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play937141010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 1.05

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(937141009).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 42 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 42)

				if (42 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 42)) > 0 and var_42_0 < var_42_3 then
					arg_39_1.talkMaxDuration = var_42_3

					if var_42_3 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_3 + 0
					end
				end

				arg_39_1.text_.text = var_42_1
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_4 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_4

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play937141010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 937141010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play937141011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1194ui_story = arg_43_1.actors_["1194ui_story"].transform.localPosition

				local var_46_0 = GameObjectTools.GetOrAddComponent(arg_43_1.actors_["1194ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_46_0 then
					var_46_0:EnableDynamicBone(false)
				end
			end

			local var_46_1 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_1 then
				arg_43_1.actors_["1194ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1194ui_story, Vector3.New(0, -0.88, -6.08), (arg_43_1.time_ - 0) / var_46_1)
				arg_43_1.actors_["1194ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1194ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1194ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1194ui_story"].transform.position).z)
				arg_43_1.actors_["1194ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1194ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1194ui_story"].transform.localEulerAngles = arg_43_1.actors_["1194ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_1 and arg_43_1.time_ < 0 + var_46_1 + arg_46_0 then
				arg_43_1.actors_["1194ui_story"].transform.localPosition = Vector3.New(0, -0.88, -6.08)
				arg_43_1.actors_["1194ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1194ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1194ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1194ui_story"].transform.position).z)
				arg_43_1.actors_["1194ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1194ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1194ui_story"].transform.localEulerAngles = arg_43_1.actors_["1194ui_story"].transform.localEulerAngles

				local var_46_2 = GameObjectTools.GetOrAddComponent(arg_43_1.actors_["1194ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_46_2 then
					var_46_2:EnableDynamicBone(true)
				end
			end

			local var_46_3 = arg_43_1.actors_["1194ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_3) and arg_43_1.var_.characterEffect1194ui_story == nil then
				arg_43_1.var_.characterEffect1194ui_story = var_46_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_4 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 and not isNil(var_46_3) then
				if arg_43_1.var_.characterEffect1194ui_story and not isNil(var_46_3) then
					arg_43_1.var_.characterEffect1194ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 and not isNil(var_46_3) and arg_43_1.var_.characterEffect1194ui_story then
				arg_43_1.var_.characterEffect1194ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1194ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_46_6 = 0
			local var_46_7 = 0.225

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_6 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_8 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(937141010).content)

				arg_43_1.text_.text = var_46_8

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_10 = 9 <= 0 and var_46_7 or var_46_7 * (utf8.len(var_46_8) / 9)

				if (9 <= 0 and var_46_7 or var_46_7 * (utf8.len(var_46_8) / 9)) > 0 and var_46_7 < var_46_10 then
					arg_43_1.talkMaxDuration = var_46_10

					if var_46_10 + var_46_6 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_6
					end
				end

				arg_43_1.text_.text = var_46_8
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_11 = math.max(var_46_7, arg_43_1.talkMaxDuration)

			if var_46_6 <= arg_43_1.time_ and arg_43_1.time_ < var_46_6 + var_46_11 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_6) / var_46_11

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_6 + var_46_11 and arg_43_1.time_ < var_46_6 + var_46_11 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play937141011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 937141011
		arg_47_1.duration_ = 9

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play937141012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if arg_47_1.bgs_.H02a == nil then
				local var_50_0 = Object.Instantiate(arg_47_1.paintGo_)

				var_50_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H02a")
				var_50_0.name = "H02a"
				var_50_0.transform.parent = arg_47_1.stage_.transform
				var_50_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.bgs_.H02a = var_50_0
			end

			if 2 < arg_47_1.time_ and arg_47_1.time_ <= 2 + arg_50_0 then
				local var_50_1 = arg_47_1.bgs_.H02a

				arg_47_1.bgs_.H02a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_50_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_50_2 = var_50_1:GetComponent("SpriteRenderer")

				if var_50_2 and var_50_2.sprite then
					local var_50_3 = 2 * (var_50_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_50_1.transform.localScale = Vector3.New(var_50_3 / var_50_2.sprite.bounds.size.y < var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x and var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x or var_50_3 / var_50_2.sprite.bounds.size.y, var_50_3 / var_50_2.sprite.bounds.size.y < var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x and var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x or var_50_3 / var_50_2.sprite.bounds.size.y, 0)
				end

				for iter_50_0, iter_50_1 in pairs(arg_47_1.bgs_) do
					if iter_50_0 ~= "H02a" then
						iter_50_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_50_4 = 4

			if 4 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.allBtn_.enabled = false
			end

			if arg_47_1.time_ >= var_50_4 + 0.3 and arg_47_1.time_ < var_50_4 + 0.3 + arg_50_0 then
				arg_47_1.allBtn_.enabled = true
			end

			local var_50_5 = 0

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_5 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_6 = 2

			if var_50_5 <= arg_47_1.time_ and arg_47_1.time_ < var_50_5 + var_50_6 then
				local var_50_7 = Color.New(0, 0, 0)

				var_50_7.a = Mathf.Lerp(0, 1, (arg_47_1.time_ - var_50_5) / var_50_6)
				arg_47_1.mask_.color = var_50_7
			end

			if arg_47_1.time_ >= var_50_5 + var_50_6 and arg_47_1.time_ < var_50_5 + var_50_6 + arg_50_0 then
				local var_50_8 = Color.New(0, 0, 0)

				var_50_8.a = 1
				arg_47_1.mask_.color = var_50_8
			end

			local var_50_9 = 2

			if 2 < arg_47_1.time_ and arg_47_1.time_ <= var_50_9 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_10 = 2

			if var_50_9 <= arg_47_1.time_ and arg_47_1.time_ < var_50_9 + var_50_10 then
				local var_50_11 = Color.New(0, 0, 0)

				var_50_11.a = Mathf.Lerp(1, 0, (arg_47_1.time_ - var_50_9) / var_50_10)
				arg_47_1.mask_.color = var_50_11
			end

			if arg_47_1.time_ >= var_50_9 + var_50_10 and arg_47_1.time_ < var_50_9 + var_50_10 + arg_50_0 then
				local var_50_12 = Color.New(0, 0, 0)

				arg_47_1.mask_.enabled = false
				var_50_12.a = 0
				arg_47_1.mask_.color = var_50_12
			end

			local var_50_13 = arg_47_1.actors_["1194ui_story"].transform

			if 1.96599999815226 < arg_47_1.time_ and arg_47_1.time_ <= 1.96599999815226 + arg_50_0 then
				arg_47_1.var_.moveOldPos1194ui_story = var_50_13.localPosition

				local var_50_14 = GameObjectTools.GetOrAddComponent(var_50_13.gameObject, typeof(DynamicBoneHelper))

				if var_50_14 then
					var_50_14:EnableDynamicBone(false)
				end
			end

			local var_50_15 = 0.001

			if 1.96599999815226 <= arg_47_1.time_ and arg_47_1.time_ < 1.96599999815226 + var_50_15 then
				var_50_13.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1194ui_story, Vector3.New(0, 100, 0), (arg_47_1.time_ - 1.96599999815226) / var_50_15)
				var_50_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_13.position).x, (manager.ui.mainCamera.transform.position - var_50_13.position).y, (manager.ui.mainCamera.transform.position - var_50_13.position).z)
				var_50_13.localEulerAngles.z = 0
				var_50_13.localEulerAngles.x = 0
				var_50_13.localEulerAngles = var_50_13.localEulerAngles
			end

			if arg_47_1.time_ >= 1.96599999815226 + var_50_15 and arg_47_1.time_ < 1.96599999815226 + var_50_15 + arg_50_0 then
				var_50_13.localPosition = Vector3.New(0, 100, 0)
				var_50_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_13.position).x, (manager.ui.mainCamera.transform.position - var_50_13.position).y, (manager.ui.mainCamera.transform.position - var_50_13.position).z)
				var_50_13.localEulerAngles.z = 0
				var_50_13.localEulerAngles.x = 0
				var_50_13.localEulerAngles = var_50_13.localEulerAngles

				local var_50_16 = GameObjectTools.GetOrAddComponent(var_50_13.gameObject, typeof(DynamicBoneHelper))

				if var_50_16 then
					var_50_16:EnableDynamicBone(true)
				end
			end

			local var_50_17 = arg_47_1.actors_["1194ui_story"]

			if 1.96599999815226 < arg_47_1.time_ and arg_47_1.time_ <= 1.96599999815226 + arg_50_0 and not isNil(var_50_17) and arg_47_1.var_.characterEffect1194ui_story == nil then
				arg_47_1.var_.characterEffect1194ui_story = var_50_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_18 = 0.034000001847744

			if 1.96599999815226 <= arg_47_1.time_ and arg_47_1.time_ < 1.96599999815226 + var_50_18 and not isNil(var_50_17) then
				if arg_47_1.var_.characterEffect1194ui_story and not isNil(var_50_17) then
					arg_47_1.var_.characterEffect1194ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1194ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 1.96599999815226) / var_50_18)
				end
			end

			if arg_47_1.time_ >= 1.96599999815226 + var_50_18 and arg_47_1.time_ < 1.96599999815226 + var_50_18 + arg_50_0 and not isNil(var_50_17) and arg_47_1.var_.characterEffect1194ui_story then
				arg_47_1.var_.characterEffect1194ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1194ui_story.fillRatio = 0.5
			end

			if 2 < arg_47_1.time_ and arg_47_1.time_ <= 2 + arg_50_0 then
				if arg_47_1.var_.effecthailaqingrenjiexiayu1 then
					Object.Destroy(arg_47_1.var_.effecthailaqingrenjiexiayu1)

					arg_47_1.var_.effecthailaqingrenjiexiayu1 = nil
				end
			end

			if arg_47_1.frameCnt_ <= 1 then
				arg_47_1.dialog_:SetActive(false)
			end

			local var_50_20 = 4
			local var_50_21 = 1.1

			if 4 < arg_47_1.time_ and arg_47_1.time_ <= var_50_20 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_22 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_22:setOnUpdate(LuaHelper.FloatAction(function(arg_51_0)
					arg_47_1.dialogCg_.alpha = arg_51_0
				end))
				var_50_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_23 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(937141011).content)

				arg_47_1.text_.text = var_50_23

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_25 = 44 <= 0 and var_50_21 or var_50_21 * (utf8.len(var_50_23) / 44)

				if (44 <= 0 and var_50_21 or var_50_21 * (utf8.len(var_50_23) / 44)) > 0 and var_50_21 < var_50_25 then
					arg_47_1.talkMaxDuration = var_50_25
					var_50_20 = var_50_20 + 0.3

					if var_50_25 + var_50_20 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_25 + var_50_20
					end
				end

				arg_47_1.text_.text = var_50_23
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_26 = var_50_20 + 0.3
			local var_50_27 = math.max(var_50_21, arg_47_1.talkMaxDuration)

			if var_50_20 + 0.3 <= arg_47_1.time_ and arg_47_1.time_ < var_50_26 + var_50_27 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_26) / var_50_27

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_26 + var_50_27 and arg_47_1.time_ < var_50_26 + var_50_27 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play937141012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 937141012
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play937141013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.25

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(937141012).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 10 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 10)

				if (10 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 10)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play937141013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 937141013
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play937141014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1194ui_story = arg_57_1.actors_["1194ui_story"].transform.localPosition

				local var_60_0 = GameObjectTools.GetOrAddComponent(arg_57_1.actors_["1194ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_60_0 then
					var_60_0:EnableDynamicBone(false)
				end
			end

			local var_60_1 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 then
				arg_57_1.actors_["1194ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1194ui_story, Vector3.New(0, -0.88, -6.08), (arg_57_1.time_ - 0) / var_60_1)
				arg_57_1.actors_["1194ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1194ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1194ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1194ui_story"].transform.position).z)
				arg_57_1.actors_["1194ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1194ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1194ui_story"].transform.localEulerAngles = arg_57_1.actors_["1194ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 then
				arg_57_1.actors_["1194ui_story"].transform.localPosition = Vector3.New(0, -0.88, -6.08)
				arg_57_1.actors_["1194ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["1194ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1194ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["1194ui_story"].transform.position).z)
				arg_57_1.actors_["1194ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["1194ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["1194ui_story"].transform.localEulerAngles = arg_57_1.actors_["1194ui_story"].transform.localEulerAngles

				local var_60_2 = GameObjectTools.GetOrAddComponent(arg_57_1.actors_["1194ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_60_2 then
					var_60_2:EnableDynamicBone(true)
				end
			end

			local var_60_3 = arg_57_1.actors_["1194ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect1194ui_story == nil then
				arg_57_1.var_.characterEffect1194ui_story = var_60_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_4 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 and not isNil(var_60_3) then
				if arg_57_1.var_.characterEffect1194ui_story and not isNil(var_60_3) then
					arg_57_1.var_.characterEffect1194ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 and not isNil(var_60_3) and arg_57_1.var_.characterEffect1194ui_story then
				arg_57_1.var_.characterEffect1194ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1194ui_story", "StoryTimeline/CharAction/story1194/story1194action/1194action5_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1194ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_60_6 = 0
			local var_60_7 = 0.275

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_8 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(937141013).content)

				arg_57_1.text_.text = var_60_8

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 11 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_8) / 11)

				if (11 <= 0 and var_60_7 or var_60_7 * (utf8.len(var_60_8) / 11)) > 0 and var_60_7 < var_60_10 then
					arg_57_1.talkMaxDuration = var_60_10

					if var_60_10 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_8
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_11 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_11 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_11

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_11 and arg_57_1.time_ < var_60_6 + var_60_11 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play937141014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 937141014
		arg_61_1.duration_ = 8.67

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play937141015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 2 < arg_61_1.time_ and arg_61_1.time_ <= 2 + arg_64_0 then
				arg_61_1.var_.moveOldPos1194ui_story = arg_61_1.actors_["1194ui_story"].transform.localPosition

				local var_64_0 = GameObjectTools.GetOrAddComponent(arg_61_1.actors_["1194ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_64_0 then
					var_64_0:EnableDynamicBone(false)
				end
			end

			local var_64_1 = 0.001

			if 2 <= arg_61_1.time_ and arg_61_1.time_ < 2 + var_64_1 then
				arg_61_1.actors_["1194ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1194ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 2) / var_64_1)
				arg_61_1.actors_["1194ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1194ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1194ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1194ui_story"].transform.position).z)
				arg_61_1.actors_["1194ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1194ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1194ui_story"].transform.localEulerAngles = arg_61_1.actors_["1194ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 2 + var_64_1 and arg_61_1.time_ < 2 + var_64_1 + arg_64_0 then
				arg_61_1.actors_["1194ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["1194ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["1194ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1194ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["1194ui_story"].transform.position).z)
				arg_61_1.actors_["1194ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["1194ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["1194ui_story"].transform.localEulerAngles = arg_61_1.actors_["1194ui_story"].transform.localEulerAngles

				local var_64_2 = GameObjectTools.GetOrAddComponent(arg_61_1.actors_["1194ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_64_2 then
					var_64_2:EnableDynamicBone(true)
				end
			end

			local var_64_3 = arg_61_1.actors_["1194ui_story"]

			if 2 < arg_61_1.time_ and arg_61_1.time_ <= 2 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect1194ui_story == nil then
				arg_61_1.var_.characterEffect1194ui_story = var_64_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_4 = 0.200000002980232

			if 2 <= arg_61_1.time_ and arg_61_1.time_ < 2 + var_64_4 and not isNil(var_64_3) then
				if arg_61_1.var_.characterEffect1194ui_story and not isNil(var_64_3) then
					arg_61_1.var_.characterEffect1194ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1194ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 2) / var_64_4)
				end
			end

			if arg_61_1.time_ >= 2 + var_64_4 and arg_61_1.time_ < 2 + var_64_4 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect1194ui_story then
				arg_61_1.var_.characterEffect1194ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1194ui_story.fillRatio = 0.5
			end

			local var_64_5 = 0

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_6 = 2

			if var_64_5 <= arg_61_1.time_ and arg_61_1.time_ < var_64_5 + var_64_6 then
				local var_64_7 = Color.New(0, 0, 0)

				var_64_7.a = Mathf.Lerp(0, 1, (arg_61_1.time_ - var_64_5) / var_64_6)
				arg_61_1.mask_.color = var_64_7
			end

			if arg_61_1.time_ >= var_64_5 + var_64_6 and arg_61_1.time_ < var_64_5 + var_64_6 + arg_64_0 then
				local var_64_8 = Color.New(0, 0, 0)

				var_64_8.a = 1
				arg_61_1.mask_.color = var_64_8
			end

			local var_64_9 = 2

			if 2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 then
				arg_61_1.mask_.enabled = true
				arg_61_1.mask_.raycastTarget = true

				arg_61_1:SetGaussion(false)
			end

			local var_64_10 = 2

			if var_64_9 <= arg_61_1.time_ and arg_61_1.time_ < var_64_9 + var_64_10 then
				local var_64_11 = Color.New(0, 0, 0)

				var_64_11.a = Mathf.Lerp(1, 0, (arg_61_1.time_ - var_64_9) / var_64_10)
				arg_61_1.mask_.color = var_64_11
			end

			if arg_61_1.time_ >= var_64_9 + var_64_10 and arg_61_1.time_ < var_64_9 + var_64_10 + arg_64_0 then
				local var_64_12 = Color.New(0, 0, 0)

				arg_61_1.mask_.enabled = false
				var_64_12.a = 0
				arg_61_1.mask_.color = var_64_12
			end

			local var_64_13 = arg_61_1.bgs_.H02a.transform

			if 2 < arg_61_1.time_ and arg_61_1.time_ <= 2 + arg_64_0 then
				arg_61_1.var_.moveOldPosH02a = var_64_13.localPosition
			end

			local var_64_14 = 5.96666666666667

			if 2 <= arg_61_1.time_ and arg_61_1.time_ < 2 + var_64_14 then
				var_64_13.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPosH02a, Vector3.New(1, 0, 5), (arg_61_1.time_ - 2) / var_64_14)
			end

			if arg_61_1.time_ >= 2 + var_64_14 and arg_61_1.time_ < 2 + var_64_14 + arg_64_0 then
				var_64_13.localPosition = Vector3.New(1, 0, 5)
			end

			local var_64_15 = 4

			if 4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 then
				arg_61_1.allBtn_.enabled = false
			end

			if arg_61_1.time_ >= var_64_15 + 3.96666666666667 and arg_61_1.time_ < var_64_15 + 3.96666666666667 + arg_64_0 then
				arg_61_1.allBtn_.enabled = true
			end

			local var_64_16 = 3.66666666666667
			local var_64_17 = 1.5

			if 3.66666666666667 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_18 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(937141014).content)

				arg_61_1.text_.text = var_64_18

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_20 = 60 <= 0 and var_64_17 or var_64_17 * (utf8.len(var_64_18) / 60)

				if (60 <= 0 and var_64_17 or var_64_17 * (utf8.len(var_64_18) / 60)) > 0 and var_64_17 < var_64_20 then
					arg_61_1.talkMaxDuration = var_64_20

					if var_64_20 + var_64_16 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_20 + var_64_16
					end
				end

				arg_61_1.text_.text = var_64_18
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_21 = math.max(var_64_17, arg_61_1.talkMaxDuration)

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_21 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_16) / var_64_21

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_16 + var_64_21 and arg_61_1.time_ < var_64_16 + var_64_21 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "H02a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 5.96666666666667,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 5),
					endPos = Vector3.New(1, 0, 5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play937141015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 937141015
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play937141016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.4

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(937141015).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 16 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 16)

				if (16 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 16)) > 0 and var_68_0 < var_68_3 then
					arg_65_1.talkMaxDuration = var_68_3

					if var_68_3 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_3 + 0
					end
				end

				arg_65_1.text_.text = var_68_1
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_4 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_4

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play937141016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 937141016
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play937141017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 1.125

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1194_split_5")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(937141016).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 45 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 45)

				if (45 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 45)) > 0 and var_72_0 < var_72_3 then
					arg_69_1.talkMaxDuration = var_72_3

					if var_72_3 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_3 + 0
					end
				end

				arg_69_1.text_.text = var_72_1
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_4 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_4

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play937141017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 937141017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
			arg_73_1.auto_ = false
		end

		function arg_73_1.playNext_(arg_75_0)
			arg_73_1.onStoryFinished_()
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.75

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1194_split_2")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_1 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(937141017).content)

				arg_73_1.text_.text = var_76_1

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_3 = 30 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 30)

				if (30 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 30)) > 0 and var_76_0 < var_76_3 then
					arg_73_1.talkMaxDuration = var_76_3

					if var_76_3 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_3 + 0
					end
				end

				arg_73_1.text_.text = var_76_1
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_4 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_4

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H03a",
		"TextureConfig/Background/H02a"
	},
	voices = {}
}
