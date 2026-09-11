return {
	Play939012001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 939012001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play939012002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I05a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I05a")
				var_4_0.name = "I05a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I05a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I05a

				arg_1_1.bgs_.I05a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I05a" then
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

			local var_4_9 = "1054ui_story"

			if arg_1_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["1054ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1054ui_story = var_4_13.localPosition

				local var_4_14 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_14 then
					var_4_14:EnableDynamicBone(false)
				end
			end

			local var_4_15 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_1_1.time_ - 1.8) / var_4_15)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -0.985, -6)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles

				local var_4_16 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_16 then
					var_4_16:EnableDynamicBone(true)
				end
			end

			local var_4_17 = arg_1_1.actors_["1054ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect1054ui_story == nil then
				arg_1_1.var_.characterEffect1054ui_story = var_4_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_18 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_18 and not isNil(var_4_17) then
				if arg_1_1.var_.characterEffect1054ui_story and not isNil(var_4_17) then
					arg_1_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_18 and arg_1_1.time_ < 1.8 + var_4_18 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect1054ui_story then
				arg_1_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "ui_battle.awb")

				local var_4_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
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

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_4_25 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_25 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_25

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_25
						arg_1_1.bgmTxt2_.text = var_4_25
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

			local var_4_26 = 2
			local var_4_27 = 0.7

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_28 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_28:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_29 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(939012001).content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 28 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_29) / 28)

				if (28 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_29) / 28)) > 0 and var_4_27 < var_4_31 then
					arg_1_1.talkMaxDuration = var_4_31
					var_4_26 = var_4_26 + 0.3

					if var_4_31 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_26
					end
				end

				arg_1_1.text_.text = var_4_29
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_32 = var_4_26 + 0.3
			local var_4_33 = math.max(var_4_27, arg_1_1.talkMaxDuration)

			if var_4_26 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_32) / var_4_33

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play939012002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 939012002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play939012003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1054ui_story"]) and arg_9_1.var_.characterEffect1054ui_story == nil then
				arg_9_1.var_.characterEffect1054ui_story = arg_9_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_0 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1054ui_story"]) then
				if arg_9_1.var_.characterEffect1054ui_story and not isNil(arg_9_1.actors_["1054ui_story"]) then
					arg_9_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_0)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1054ui_story"]) and arg_9_1.var_.characterEffect1054ui_story then
				arg_9_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_12_1 = 0
			local var_12_2 = 0.35

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(939012002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 14 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 14)

				if (14 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 14)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play939012003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 939012003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play939012004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1054ui_story = arg_13_1.actors_["1054ui_story"].transform.localPosition

				local var_16_0 = GameObjectTools.GetOrAddComponent(arg_13_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_16_0 then
					var_16_0:EnableDynamicBone(false)
				end
			end

			local var_16_1 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 then
				arg_13_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_13_1.time_ - 0) / var_16_1)
				arg_13_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1054ui_story"].transform.position).z)
				arg_13_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1054ui_story"].transform.localEulerAngles = arg_13_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 then
				arg_13_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["1054ui_story"].transform.position).z)
				arg_13_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["1054ui_story"].transform.localEulerAngles = arg_13_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_16_2 = GameObjectTools.GetOrAddComponent(arg_13_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(true)
				end
			end

			local var_16_3 = 0
			local var_16_4 = 0.6

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_3 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_5 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(939012003).content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_7 = 24 <= 0 and var_16_4 or var_16_4 * (utf8.len(var_16_5) / 24)

				if (24 <= 0 and var_16_4 or var_16_4 * (utf8.len(var_16_5) / 24)) > 0 and var_16_4 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_3 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_3
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_8 = math.max(var_16_4, arg_13_1.talkMaxDuration)

			if var_16_3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_3 + var_16_8 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_3) / var_16_8

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_3 + var_16_8 and arg_13_1.time_ < var_16_3 + var_16_8 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play939012004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 939012004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play939012005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1054ui_story = arg_17_1.actors_["1054ui_story"].transform.localPosition

				local var_20_0 = GameObjectTools.GetOrAddComponent(arg_17_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_20_0 then
					var_20_0:EnableDynamicBone(false)
				end
			end

			local var_20_1 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 then
				arg_17_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_17_1.time_ - 0) / var_20_1)
				arg_17_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1054ui_story"].transform.position).z)
				arg_17_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1054ui_story"].transform.localEulerAngles = arg_17_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 then
				arg_17_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_17_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1054ui_story"].transform.position).z)
				arg_17_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1054ui_story"].transform.localEulerAngles = arg_17_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_20_2 = GameObjectTools.GetOrAddComponent(arg_17_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(true)
				end
			end

			local var_20_3 = arg_17_1.actors_["1054ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_3) and arg_17_1.var_.characterEffect1054ui_story == nil then
				arg_17_1.var_.characterEffect1054ui_story = var_20_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_4 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 and not isNil(var_20_3) then
				if arg_17_1.var_.characterEffect1054ui_story and not isNil(var_20_3) then
					arg_17_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 and not isNil(var_20_3) and arg_17_1.var_.characterEffect1054ui_story then
				arg_17_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054actionlink/1054action445")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_20_6 = 0
			local var_20_7 = 0.375

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_8 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(939012004).content)

				arg_17_1.text_.text = var_20_8

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 15 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_8) / 15)

				if (15 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_8) / 15)) > 0 and var_20_7 < var_20_10 then
					arg_17_1.talkMaxDuration = var_20_10

					if var_20_10 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_8
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_11 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_11 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_11

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_11 and arg_17_1.time_ < var_20_6 + var_20_11 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play939012005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 939012005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play939012006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1054ui_story"]) and arg_21_1.var_.characterEffect1054ui_story == nil then
				arg_21_1.var_.characterEffect1054ui_story = arg_21_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1054ui_story"]) then
				if arg_21_1.var_.characterEffect1054ui_story and not isNil(arg_21_1.actors_["1054ui_story"]) then
					arg_21_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_0)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1054ui_story"]) and arg_21_1.var_.characterEffect1054ui_story then
				arg_21_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_24_1 = 0
			local var_24_2 = 0.6

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_3 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(939012005).content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_5 = 24 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 24)

				if (24 <= 0 and var_24_2 or var_24_2 * (utf8.len(var_24_3) / 24)) > 0 and var_24_2 < var_24_5 then
					arg_21_1.talkMaxDuration = var_24_5

					if var_24_5 + var_24_1 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + var_24_1
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_6 = math.max(var_24_2, arg_21_1.talkMaxDuration)

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_6 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_1) / var_24_6

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_1 + var_24_6 and arg_21_1.time_ < var_24_1 + var_24_6 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play939012006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 939012006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play939012007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1054ui_story = arg_25_1.actors_["1054ui_story"].transform.localPosition

				local var_28_0 = GameObjectTools.GetOrAddComponent(arg_25_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_28_0 then
					var_28_0:EnableDynamicBone(false)
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_1)
				arg_25_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1054ui_story"].transform.position).z)
				arg_25_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1054ui_story"].transform.localEulerAngles = arg_25_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["1054ui_story"].transform.position).z)
				arg_25_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["1054ui_story"].transform.localEulerAngles = arg_25_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_28_2 = GameObjectTools.GetOrAddComponent(arg_25_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(true)
				end
			end

			local var_28_3 = 0
			local var_28_4 = 0.425

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1248")

				arg_25_1.callingController_:SetSelectedState("calling")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_5 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(939012006).content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 17 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 17)

				if (17 <= 0 and var_28_4 or var_28_4 * (utf8.len(var_28_5) / 17)) > 0 and var_28_4 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_3 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_3
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_4, arg_25_1.talkMaxDuration)

			if var_28_3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_3 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_3) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_3 + var_28_8 and arg_25_1.time_ < var_28_3 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play939012007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 939012007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play939012008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 1.325

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1248")

				arg_29_1.callingController_:SetSelectedState("calling")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(939012007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 53 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 53)

				if (53 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 53)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play939012008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 939012008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play939012009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.actors_["1248ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1248ui_story"))) then
				local var_36_0 = Object.Instantiate(Asset.Load("Char/" .. "1248ui_story"), arg_33_1.stage_.transform)

				var_36_0.name = "1248ui_story"
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.actors_["1248ui_story"] = var_36_0

				local var_36_1 = var_36_0:GetComponentInChildren(typeof(CharacterEffect))

				var_36_1.enabled = true

				local var_36_2 = GameObjectTools.GetOrAddComponent(var_36_0, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(false)
				end

				arg_33_1:ShowWeapon(var_36_1.transform, false)

				arg_33_1.var_["1248ui_story" .. "Animator"] = var_36_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_33_1.var_["1248ui_story" .. "Animator"].applyRootMotion = true
				arg_33_1.var_["1248ui_story" .. "LipSync"] = var_36_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_36_3 = arg_33_1.actors_["1248ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_3) and arg_33_1.var_.characterEffect1248ui_story == nil then
				arg_33_1.var_.characterEffect1248ui_story = var_36_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_4 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 and not isNil(var_36_3) then
				if arg_33_1.var_.characterEffect1248ui_story and not isNil(var_36_3) then
					arg_33_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1248ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_4)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 and not isNil(var_36_3) and arg_33_1.var_.characterEffect1248ui_story then
				arg_33_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1248ui_story.fillRatio = 0.5
			end

			local var_36_5 = 0
			local var_36_6 = 0.125

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_7 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(939012008).content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 5 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_7) / 5)

				if (5 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_7) / 5)) > 0 and var_36_6 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_6, arg_33_1.talkMaxDuration)

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_5) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_5 + var_36_10 and arg_33_1.time_ < var_36_5 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play939012009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 939012009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play939012010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 1.325

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1248")

				arg_37_1.callingController_:SetSelectedState("calling")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(939012009).content)

				arg_37_1.text_.text = var_40_1

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_3 = 53 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 53)

				if (53 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_1) / 53)) > 0 and var_40_0 < var_40_3 then
					arg_37_1.talkMaxDuration = var_40_3

					if var_40_3 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_3 + 0
					end
				end

				arg_37_1.text_.text = var_40_1
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_4 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_4

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play939012010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 939012010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play939012011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1248ui_story"]) and arg_41_1.var_.characterEffect1248ui_story == nil then
				arg_41_1.var_.characterEffect1248ui_story = arg_41_1.actors_["1248ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1248ui_story"]) then
				if arg_41_1.var_.characterEffect1248ui_story and not isNil(arg_41_1.actors_["1248ui_story"]) then
					arg_41_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1248ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1248ui_story"]) and arg_41_1.var_.characterEffect1248ui_story then
				arg_41_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1248ui_story.fillRatio = 0.5
			end

			local var_44_1 = 0
			local var_44_2 = 0.4

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_3 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(939012010).content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 16 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 16)

				if (16 <= 0 and var_44_2 or var_44_2 * (utf8.len(var_44_3) / 16)) > 0 and var_44_2 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_1 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_1
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_6 = math.max(var_44_2, arg_41_1.talkMaxDuration)

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_6 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_1) / var_44_6

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_1 + var_44_6 and arg_41_1.time_ < var_44_1 + var_44_6 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play939012011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 939012011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play939012012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1.35

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1248")

				arg_45_1.callingController_:SetSelectedState("calling")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(939012011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 54 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 54)

				if (54 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 54)) > 0 and var_48_0 < var_48_3 then
					arg_45_1.talkMaxDuration = var_48_3

					if var_48_3 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_3 + 0
					end
				end

				arg_45_1.text_.text = var_48_1
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_4 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_4

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play939012012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 939012012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play939012013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1248ui_story"]) and arg_49_1.var_.characterEffect1248ui_story == nil then
				arg_49_1.var_.characterEffect1248ui_story = arg_49_1.actors_["1248ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1248ui_story"]) then
				if arg_49_1.var_.characterEffect1248ui_story and not isNil(arg_49_1.actors_["1248ui_story"]) then
					arg_49_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1248ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1248ui_story"]) and arg_49_1.var_.characterEffect1248ui_story then
				arg_49_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1248ui_story.fillRatio = 0.5
			end

			local var_52_1 = 0
			local var_52_2 = 0.6

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_3 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(939012012).content)

				arg_49_1.text_.text = var_52_3

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_5 = 24 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 24)

				if (24 <= 0 and var_52_2 or var_52_2 * (utf8.len(var_52_3) / 24)) > 0 and var_52_2 < var_52_5 then
					arg_49_1.talkMaxDuration = var_52_5

					if var_52_5 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_3
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_6 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_6 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_6

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_6 and arg_49_1.time_ < var_52_1 + var_52_6 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play939012013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 939012013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play939012014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.35

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1248")

				arg_53_1.callingController_:SetSelectedState("calling")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(939012013).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 14 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 14)

				if (14 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 14)) > 0 and var_56_0 < var_56_3 then
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
	Play939012014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 939012014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play939012015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1248ui_story"]) and arg_57_1.var_.characterEffect1248ui_story == nil then
				arg_57_1.var_.characterEffect1248ui_story = arg_57_1.actors_["1248ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1248ui_story"]) then
				if arg_57_1.var_.characterEffect1248ui_story and not isNil(arg_57_1.actors_["1248ui_story"]) then
					arg_57_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1248ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_0)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1248ui_story"]) and arg_57_1.var_.characterEffect1248ui_story then
				arg_57_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1248ui_story.fillRatio = 0.5
			end

			local var_60_1 = 0
			local var_60_2 = 0.225

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_3 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(939012014).content)

				arg_57_1.text_.text = var_60_3

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 9 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 9)

				if (9 <= 0 and var_60_2 or var_60_2 * (utf8.len(var_60_3) / 9)) > 0 and var_60_2 < var_60_5 then
					arg_57_1.talkMaxDuration = var_60_5

					if var_60_5 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_3
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_6 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_6 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_6

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_6 and arg_57_1.time_ < var_60_1 + var_60_6 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play939012015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 939012015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play939012016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if arg_61_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_64_0 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_61_1.stage_.transform)

				var_64_0.name = "6148ui_story"
				var_64_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_61_1.actors_["6148ui_story"] = var_64_0

				local var_64_1 = var_64_0:GetComponentInChildren(typeof(CharacterEffect))

				var_64_1.enabled = true

				local var_64_2 = GameObjectTools.GetOrAddComponent(var_64_0, typeof(DynamicBoneHelper))

				if var_64_2 then
					var_64_2:EnableDynamicBone(false)
				end

				arg_61_1:ShowWeapon(var_64_1.transform, false)

				arg_61_1.var_["6148ui_story" .. "Animator"] = var_64_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_61_1.var_["6148ui_story" .. "Animator"].applyRootMotion = true
				arg_61_1.var_["6148ui_story" .. "LipSync"] = var_64_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_64_3 = arg_61_1.actors_["6148ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos6148ui_story = var_64_3.localPosition

				local var_64_4 = GameObjectTools.GetOrAddComponent(var_64_3.gameObject, typeof(DynamicBoneHelper))

				if var_64_4 then
					var_64_4:EnableDynamicBone(false)
				end
			end

			local var_64_5 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_5 then
				var_64_3.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_61_1.time_ - 0) / var_64_5)
				var_64_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_3.position).x, (manager.ui.mainCamera.transform.position - var_64_3.position).y, (manager.ui.mainCamera.transform.position - var_64_3.position).z)
				var_64_3.localEulerAngles.z = 0
				var_64_3.localEulerAngles.x = 0
				var_64_3.localEulerAngles = var_64_3.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_5 and arg_61_1.time_ < 0 + var_64_5 + arg_64_0 then
				var_64_3.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_64_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_3.position).x, (manager.ui.mainCamera.transform.position - var_64_3.position).y, (manager.ui.mainCamera.transform.position - var_64_3.position).z)
				var_64_3.localEulerAngles.z = 0
				var_64_3.localEulerAngles.x = 0
				var_64_3.localEulerAngles = var_64_3.localEulerAngles

				local var_64_6 = GameObjectTools.GetOrAddComponent(var_64_3.gameObject, typeof(DynamicBoneHelper))

				if var_64_6 then
					var_64_6:EnableDynamicBone(true)
				end
			end

			local var_64_7 = arg_61_1.actors_["1248ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1248ui_story = var_64_7.localPosition
			end

			local var_64_8 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_8 then
				var_64_7.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1248ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_8)
				var_64_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_7.position).x, (manager.ui.mainCamera.transform.position - var_64_7.position).y, (manager.ui.mainCamera.transform.position - var_64_7.position).z)
				var_64_7.localEulerAngles.z = 0
				var_64_7.localEulerAngles.x = 0
				var_64_7.localEulerAngles = var_64_7.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_8 and arg_61_1.time_ < 0 + var_64_8 + arg_64_0 then
				var_64_7.localPosition = Vector3.New(0, 100, 0)
				var_64_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_7.position).x, (manager.ui.mainCamera.transform.position - var_64_7.position).y, (manager.ui.mainCamera.transform.position - var_64_7.position).z)
				var_64_7.localEulerAngles.z = 0
				var_64_7.localEulerAngles.x = 0
				var_64_7.localEulerAngles = var_64_7.localEulerAngles
			end

			local var_64_9 = arg_61_1.actors_["6148ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect6148ui_story == nil then
				arg_61_1.var_.characterEffect6148ui_story = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_10 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_10 and not isNil(var_64_9) then
				if arg_61_1.var_.characterEffect6148ui_story and not isNil(var_64_9) then
					arg_61_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_10 and arg_61_1.time_ < 0 + var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect6148ui_story then
				arg_61_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_64_12 = 0
			local var_64_13 = 1.525

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_12 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_14 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(939012015).content)

				arg_61_1.text_.text = var_64_14

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_16 = 61 <= 0 and var_64_13 or var_64_13 * (utf8.len(var_64_14) / 61)

				if (61 <= 0 and var_64_13 or var_64_13 * (utf8.len(var_64_14) / 61)) > 0 and var_64_13 < var_64_16 then
					arg_61_1.talkMaxDuration = var_64_16

					if var_64_16 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_16 + var_64_12
					end
				end

				arg_61_1.text_.text = var_64_14
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_17 = math.max(var_64_13, arg_61_1.talkMaxDuration)

			if var_64_12 <= arg_61_1.time_ and arg_61_1.time_ < var_64_12 + var_64_17 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_12) / var_64_17

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_12 + var_64_17 and arg_61_1.time_ < var_64_12 + var_64_17 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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
				actorName = "1248ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play939012016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 939012016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play939012017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1054ui_story = arg_65_1.actors_["1054ui_story"].transform.localPosition

				local var_68_0 = GameObjectTools.GetOrAddComponent(arg_65_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_68_0 then
					var_68_0:EnableDynamicBone(false)
				end
			end

			local var_68_1 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 then
				arg_65_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_65_1.time_ - 0) / var_68_1)
				arg_65_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1054ui_story"].transform.position).z)
				arg_65_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1054ui_story"].transform.localEulerAngles = arg_65_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 then
				arg_65_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_65_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1054ui_story"].transform.position).z)
				arg_65_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1054ui_story"].transform.localEulerAngles = arg_65_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_68_2 = GameObjectTools.GetOrAddComponent(arg_65_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_68_2 then
					var_68_2:EnableDynamicBone(true)
				end
			end

			local var_68_3 = arg_65_1.actors_["1054ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_3) and arg_65_1.var_.characterEffect1054ui_story == nil then
				arg_65_1.var_.characterEffect1054ui_story = var_68_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_4 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 and not isNil(var_68_3) then
				if arg_65_1.var_.characterEffect1054ui_story and not isNil(var_68_3) then
					arg_65_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 and not isNil(var_68_3) and arg_65_1.var_.characterEffect1054ui_story then
				arg_65_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_68_6 = arg_65_1.actors_["6148ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect6148ui_story == nil then
				arg_65_1.var_.characterEffect6148ui_story = var_68_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_7 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 and not isNil(var_68_6) then
				if arg_65_1.var_.characterEffect6148ui_story and not isNil(var_68_6) then
					arg_65_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_65_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_7)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect6148ui_story then
				arg_65_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_65_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_68_8 = 0
			local var_68_9 = 0.7

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_10 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(939012016).content)

				arg_65_1.text_.text = var_68_10

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_12 = 28 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_10) / 28)

				if (28 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_10) / 28)) > 0 and var_68_9 < var_68_12 then
					arg_65_1.talkMaxDuration = var_68_12

					if var_68_12 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_10
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_13 = math.max(var_68_9, arg_65_1.talkMaxDuration)

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_13 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_8) / var_68_13

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_8 + var_68_13 and arg_65_1.time_ < var_68_8 + var_68_13 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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

		arg_65_1:InitPlayNodeList()
	end,
	Play939012017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 939012017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play939012018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1054ui_story"]) and arg_69_1.var_.characterEffect1054ui_story == nil then
				arg_69_1.var_.characterEffect1054ui_story = arg_69_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1054ui_story"]) then
				if arg_69_1.var_.characterEffect1054ui_story and not isNil(arg_69_1.actors_["1054ui_story"]) then
					arg_69_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1054ui_story"]) and arg_69_1.var_.characterEffect1054ui_story then
				arg_69_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 1.15

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(939012017).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 46 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 46)

				if (46 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 46)) > 0 and var_72_2 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_6 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_6 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_6

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_6 and arg_69_1.time_ < var_72_1 + var_72_6 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play939012018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 939012018
		arg_73_1.duration_ = 6.77

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play939012019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_9000

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1054ui_story = arg_73_1.actors_["1054ui_story"].transform.localPosition

				local var_76_0 = GameObjectTools.GetOrAddComponent(arg_73_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_76_0 then
					var_76_0:EnableDynamicBone(false)
				end
			end

			local var_76_1 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 then
				arg_73_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_1)
				arg_73_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1054ui_story"].transform.position).z)
				arg_73_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1054ui_story"].transform.localEulerAngles = arg_73_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 then
				arg_73_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_73_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_73_1.actors_["1054ui_story"].transform.position).z)
				arg_73_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_73_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_73_1.actors_["1054ui_story"].transform.localEulerAngles = arg_73_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_76_2 = GameObjectTools.GetOrAddComponent(arg_73_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_76_2 then
					var_76_2:EnableDynamicBone(true)
				end
			end

			local var_76_3 = arg_73_1.actors_["6148ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos6148ui_story = var_76_3.localPosition

				local var_76_4 = GameObjectTools.GetOrAddComponent(var_76_3.gameObject, typeof(DynamicBoneHelper))

				if var_76_4 then
					var_76_4:EnableDynamicBone(false)
				end
			end

			local var_76_5 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_5 then
				var_76_3.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_73_1.time_ - 0) / var_76_5)
				var_76_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_3.position).x, (manager.ui.mainCamera.transform.position - var_76_3.position).y, (manager.ui.mainCamera.transform.position - var_76_3.position).z)
				var_76_3.localEulerAngles.z = 0
				var_76_3.localEulerAngles.x = 0
				var_76_3.localEulerAngles = var_76_3.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_5 and arg_73_1.time_ < 0 + var_76_5 + arg_76_0 then
				var_76_3.localPosition = Vector3.New(0, 100, 0)
				var_76_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_3.position).x, (manager.ui.mainCamera.transform.position - var_76_3.position).y, (manager.ui.mainCamera.transform.position - var_76_3.position).z)
				var_76_3.localEulerAngles.z = 0
				var_76_3.localEulerAngles.x = 0
				var_76_3.localEulerAngles = var_76_3.localEulerAngles

				local var_76_6 = GameObjectTools.GetOrAddComponent(var_76_3.gameObject, typeof(DynamicBoneHelper))

				if var_76_6 then
					var_76_6:EnableDynamicBone(true)
				end
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				local var_76_7 = arg_73_1.var_.effectzhezhuyanjing1

				if not arg_73_1.var_.effectzhezhuyanjing1 then
					var_76_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapshut"), manager.ui.mainCamera.transform)
					var_76_7.name = "zhezhuyanjing1"
					arg_73_1.var_.effectzhezhuyanjing1 = var_76_7
				else
					var_76_7.transform:SetParent(var_76_9000)
				end

				var_76_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_76_7.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_76_9 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_76_7.transform.localScale = Vector3.New(var_76_7.transform.localScale.x * var_76_9, var_76_7.transform.localScale.y * var_76_9, var_76_7.transform.localScale.z * var_76_9)
			end

			local var_76_10 = 0

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 then
				arg_73_1.allBtn_.enabled = false
			end

			if arg_73_1.time_ >= var_76_10 + 1.76896430058405 and arg_73_1.time_ < var_76_10 + 1.76896430058405 + arg_76_0 then
				arg_73_1.allBtn_.enabled = true
			end

			if arg_73_1.frameCnt_ <= 1 then
				arg_73_1.dialog_:SetActive(false)
			end

			local var_76_11 = 1.76896430058405
			local var_76_12 = 0.95

			if 1.76896430058405 < arg_73_1.time_ and arg_73_1.time_ <= var_76_11 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_13 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_13:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_14 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(939012018).content)

				arg_73_1.text_.text = var_76_14

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_16 = 38 <= 0 and var_76_12 or var_76_12 * (utf8.len(var_76_14) / 38)

				if (38 <= 0 and var_76_12 or var_76_12 * (utf8.len(var_76_14) / 38)) > 0 and var_76_12 < var_76_16 then
					arg_73_1.talkMaxDuration = var_76_16
					var_76_11 = var_76_11 + 0.3

					if var_76_16 + var_76_11 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_16 + var_76_11
					end
				end

				arg_73_1.text_.text = var_76_14
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_17 = var_76_11 + 0.3
			local var_76_18 = math.max(var_76_12, arg_73_1.talkMaxDuration)

			if var_76_11 + 0.3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_17 + var_76_18 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_17) / var_76_18

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_17 + var_76_18 and arg_73_1.time_ < var_76_17 + var_76_18 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play939012019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 939012019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play939012020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.25

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(939012019).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 10 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 10)

				if (10 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 10)) > 0 and var_82_0 < var_82_3 then
					arg_79_1.talkMaxDuration = var_82_3

					if var_82_3 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_3 + 0
					end
				end

				arg_79_1.text_.text = var_82_1
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_4 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_4

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play939012020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 939012020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play939012021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1054ui_story"]) and arg_83_1.var_.characterEffect1054ui_story == nil then
				arg_83_1.var_.characterEffect1054ui_story = arg_83_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1054ui_story"]) then
				if arg_83_1.var_.characterEffect1054ui_story and not isNil(arg_83_1.actors_["1054ui_story"]) then
					arg_83_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1054ui_story"]) and arg_83_1.var_.characterEffect1054ui_story then
				arg_83_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_86_2 = 0
			local var_86_3 = 0.225

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_2 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1054")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_4 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(939012020).content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_6 = 9 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_4) / 9)

				if (9 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_4) / 9)) > 0 and var_86_3 < var_86_6 then
					arg_83_1.talkMaxDuration = var_86_6

					if var_86_6 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_2
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_3, arg_83_1.talkMaxDuration)

			if var_86_2 <= arg_83_1.time_ and arg_83_1.time_ < var_86_2 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_2) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_2 + var_86_7 and arg_83_1.time_ < var_86_2 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play939012021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 939012021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play939012022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["1054ui_story"]) and arg_87_1.var_.characterEffect1054ui_story == nil then
				arg_87_1.var_.characterEffect1054ui_story = arg_87_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["1054ui_story"]) then
				if arg_87_1.var_.characterEffect1054ui_story and not isNil(arg_87_1.actors_["1054ui_story"]) then
					arg_87_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_0)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["1054ui_story"]) and arg_87_1.var_.characterEffect1054ui_story then
				arg_87_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_90_1 = 0
			local var_90_2 = 0.875

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(939012021).content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 35 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 35)

				if (35 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 35)) > 0 and var_90_2 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5

					if var_90_5 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_1
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_6 = math.max(var_90_2, arg_87_1.talkMaxDuration)

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_6 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_1) / var_90_6

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_1 + var_90_6 and arg_87_1.time_ < var_90_1 + var_90_6 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play939012022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 939012022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play939012023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.3

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_1 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(939012022).content)

				arg_91_1.text_.text = var_94_1

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_3 = 12 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 12)

				if (12 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_1) / 12)) > 0 and var_94_0 < var_94_3 then
					arg_91_1.talkMaxDuration = var_94_3

					if var_94_3 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_3 + 0
					end
				end

				arg_91_1.text_.text = var_94_1
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_4 = math.max(var_94_0, arg_91_1.talkMaxDuration)

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - 0) / var_94_4

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play939012023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 939012023
		arg_95_1.duration_ = 6.8

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play939012024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_9000

			if arg_95_1.actors_["1034ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1034ui_story"))) then
				local var_98_0 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_95_1.stage_.transform)

				var_98_0.name = "1034ui_story"
				var_98_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_95_1.actors_["1034ui_story"] = var_98_0

				local var_98_1 = var_98_0:GetComponentInChildren(typeof(CharacterEffect))

				var_98_1.enabled = true

				local var_98_2 = GameObjectTools.GetOrAddComponent(var_98_0, typeof(DynamicBoneHelper))

				if var_98_2 then
					var_98_2:EnableDynamicBone(false)
				end

				arg_95_1:ShowWeapon(var_98_1.transform, false)

				arg_95_1.var_["1034ui_story" .. "Animator"] = var_98_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_95_1.var_["1034ui_story" .. "Animator"].applyRootMotion = true
				arg_95_1.var_["1034ui_story" .. "LipSync"] = var_98_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_98_3 = arg_95_1.actors_["1034ui_story"].transform

			if 2 < arg_95_1.time_ and arg_95_1.time_ <= 2 + arg_98_0 then
				arg_95_1.var_.moveOldPos1034ui_story = var_98_3.localPosition
			end

			local var_98_4 = 0.001

			if 2 <= arg_95_1.time_ and arg_95_1.time_ < 2 + var_98_4 then
				var_98_3.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_95_1.time_ - 2) / var_98_4)
				var_98_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_3.position).x, (manager.ui.mainCamera.transform.position - var_98_3.position).y, (manager.ui.mainCamera.transform.position - var_98_3.position).z)
				var_98_3.localEulerAngles.z = 0
				var_98_3.localEulerAngles.x = 0
				var_98_3.localEulerAngles = var_98_3.localEulerAngles
			end

			if arg_95_1.time_ >= 2 + var_98_4 and arg_95_1.time_ < 2 + var_98_4 + arg_98_0 then
				var_98_3.localPosition = Vector3.New(0, -0.93, -6)
				var_98_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_98_3.position).x, (manager.ui.mainCamera.transform.position - var_98_3.position).y, (manager.ui.mainCamera.transform.position - var_98_3.position).z)
				var_98_3.localEulerAngles.z = 0
				var_98_3.localEulerAngles.x = 0
				var_98_3.localEulerAngles = var_98_3.localEulerAngles
			end

			local var_98_5 = arg_95_1.actors_["1034ui_story"]

			if 2 < arg_95_1.time_ and arg_95_1.time_ <= 2 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.characterEffect1034ui_story == nil then
				arg_95_1.var_.characterEffect1034ui_story = var_98_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_6 = 0.200000002980232

			if 2 <= arg_95_1.time_ and arg_95_1.time_ < 2 + var_98_6 and not isNil(var_98_5) then
				if arg_95_1.var_.characterEffect1034ui_story and not isNil(var_98_5) then
					arg_95_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 2 + var_98_6 and arg_95_1.time_ < 2 + var_98_6 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.characterEffect1034ui_story then
				arg_95_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 2 < arg_95_1.time_ and arg_95_1.time_ <= 2 + arg_98_0 then
				arg_95_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 2 < arg_95_1.time_ and arg_95_1.time_ <= 2 + arg_98_0 then
				arg_95_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				if arg_95_1.var_.effectzhezhuyanjing1 then
					Object.Destroy(arg_95_1.var_.effectzhezhuyanjing1)

					arg_95_1.var_.effectzhezhuyanjing1 = nil
				end
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				local var_98_9 = arg_95_1.var_.effectzhezhuyanjing2

				if not arg_95_1.var_.effectzhezhuyanjing2 then
					var_98_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_snapopen"), manager.ui.mainCamera.transform)
					var_98_9.name = "zhezhuyanjing2"
					arg_95_1.var_.effectzhezhuyanjing2 = var_98_9
				else
					var_98_9.transform:SetParent(var_98_9000)
				end

				var_98_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_98_9.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_98_11 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_98_9.transform.localScale = Vector3.New(var_98_9.transform.localScale.x * var_98_11, var_98_9.transform.localScale.y * var_98_11, var_98_9.transform.localScale.z * var_98_11)
			end

			local var_98_12 = 0

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_12 + arg_98_0 then
				arg_95_1.allBtn_.enabled = false
			end

			if arg_95_1.time_ >= var_98_12 + 2 and arg_95_1.time_ < var_98_12 + 2 + arg_98_0 then
				arg_95_1.allBtn_.enabled = true
			end

			if arg_95_1.frameCnt_ <= 1 then
				arg_95_1.dialog_:SetActive(false)
			end

			local var_98_13 = 1.79999999701977
			local var_98_14 = 1.1

			if 1.79999999701977 < arg_95_1.time_ and arg_95_1.time_ <= var_98_13 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				arg_95_1.dialog_:SetActive(true)

				arg_95_1.dialogCg_.alpha = 0

				local var_98_15 = LeanTween.value(arg_95_1.dialog_, 0, 1, 0.3)

				var_98_15:setOnUpdate(LuaHelper.FloatAction(function(arg_99_0)
					arg_95_1.dialogCg_.alpha = arg_99_0
				end))
				var_98_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_95_1.dialog_)
					var_98_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_95_1.duration_ = arg_95_1.duration_ + 0.3

				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_16 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(939012023).content)

				arg_95_1.text_.text = var_98_16

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_18 = 44 <= 0 and var_98_14 or var_98_14 * (utf8.len(var_98_16) / 44)

				if (44 <= 0 and var_98_14 or var_98_14 * (utf8.len(var_98_16) / 44)) > 0 and var_98_14 < var_98_18 then
					arg_95_1.talkMaxDuration = var_98_18
					var_98_13 = var_98_13 + 0.3

					if var_98_18 + var_98_13 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_18 + var_98_13
					end
				end

				arg_95_1.text_.text = var_98_16
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_19 = var_98_13 + 0.3
			local var_98_20 = math.max(var_98_14, arg_95_1.talkMaxDuration)

			if var_98_13 + 0.3 <= arg_95_1.time_ and arg_95_1.time_ < var_98_19 + var_98_20 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_19) / var_98_20

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_19 + var_98_20 and arg_95_1.time_ < var_98_19 + var_98_20 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play939012024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 939012024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play939012025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1034ui_story"]) and arg_101_1.var_.characterEffect1034ui_story == nil then
				arg_101_1.var_.characterEffect1034ui_story = arg_101_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1034ui_story"]) then
				if arg_101_1.var_.characterEffect1034ui_story and not isNil(arg_101_1.actors_["1034ui_story"]) then
					arg_101_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_0)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1034ui_story"]) and arg_101_1.var_.characterEffect1034ui_story then
				arg_101_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_104_1 = 0
			local var_104_2 = 0.4

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(939012024).content)

				arg_101_1.text_.text = var_104_3

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 16 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 16)

				if (16 <= 0 and var_104_2 or var_104_2 * (utf8.len(var_104_3) / 16)) > 0 and var_104_2 < var_104_5 then
					arg_101_1.talkMaxDuration = var_104_5

					if var_104_5 + var_104_1 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + var_104_1
					end
				end

				arg_101_1.text_.text = var_104_3
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_6 = math.max(var_104_2, arg_101_1.talkMaxDuration)

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_6 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_1) / var_104_6

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_1 + var_104_6 and arg_101_1.time_ < var_104_1 + var_104_6 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play939012025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 939012025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play939012026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1054ui_story = arg_105_1.actors_["1054ui_story"].transform.localPosition

				local var_108_0 = GameObjectTools.GetOrAddComponent(arg_105_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_108_0 then
					var_108_0:EnableDynamicBone(false)
				end
			end

			local var_108_1 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 then
				arg_105_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_105_1.time_ - 0) / var_108_1)
				arg_105_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1054ui_story"].transform.position).z)
				arg_105_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1054ui_story"].transform.localEulerAngles = arg_105_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 then
				arg_105_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_105_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["1054ui_story"].transform.position).z)
				arg_105_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["1054ui_story"].transform.localEulerAngles = arg_105_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_108_2 = GameObjectTools.GetOrAddComponent(arg_105_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_108_2 then
					var_108_2:EnableDynamicBone(true)
				end
			end

			local var_108_3 = arg_105_1.actors_["1034ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1034ui_story = var_108_3.localPosition
			end

			local var_108_4 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				var_108_3.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1034ui_story, Vector3.New(-0.7, -0.93, -6), (arg_105_1.time_ - 0) / var_108_4)
				var_108_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_3.position).x, (manager.ui.mainCamera.transform.position - var_108_3.position).y, (manager.ui.mainCamera.transform.position - var_108_3.position).z)
				var_108_3.localEulerAngles.z = 0
				var_108_3.localEulerAngles.x = 0
				var_108_3.localEulerAngles = var_108_3.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				var_108_3.localPosition = Vector3.New(-0.7, -0.93, -6)
				var_108_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_3.position).x, (manager.ui.mainCamera.transform.position - var_108_3.position).y, (manager.ui.mainCamera.transform.position - var_108_3.position).z)
				var_108_3.localEulerAngles.z = 0
				var_108_3.localEulerAngles.x = 0
				var_108_3.localEulerAngles = var_108_3.localEulerAngles
			end

			local var_108_5 = arg_105_1.actors_["1054ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.characterEffect1054ui_story == nil then
				arg_105_1.var_.characterEffect1054ui_story = var_108_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_6 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_6 and not isNil(var_108_5) then
				if arg_105_1.var_.characterEffect1054ui_story and not isNil(var_108_5) then
					arg_105_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_6 and arg_105_1.time_ < 0 + var_108_6 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.characterEffect1054ui_story then
				arg_105_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_108_8 = 0
			local var_108_9 = 0.2

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_8 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_10 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(939012025).content)

				arg_105_1.text_.text = var_108_10

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_12 = 8 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_10) / 8)

				if (8 <= 0 and var_108_9 or var_108_9 * (utf8.len(var_108_10) / 8)) > 0 and var_108_9 < var_108_12 then
					arg_105_1.talkMaxDuration = var_108_12

					if var_108_12 + var_108_8 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_12 + var_108_8
					end
				end

				arg_105_1.text_.text = var_108_10
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_13 = math.max(var_108_9, arg_105_1.talkMaxDuration)

			if var_108_8 <= arg_105_1.time_ and arg_105_1.time_ < var_108_8 + var_108_13 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_8) / var_108_13

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_8 + var_108_13 and arg_105_1.time_ < var_108_8 + var_108_13 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
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
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play939012026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 939012026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play939012027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1054ui_story"]) and arg_109_1.var_.characterEffect1054ui_story == nil then
				arg_109_1.var_.characterEffect1054ui_story = arg_109_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1054ui_story"]) then
				if arg_109_1.var_.characterEffect1054ui_story and not isNil(arg_109_1.actors_["1054ui_story"]) then
					arg_109_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_0)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1054ui_story"]) and arg_109_1.var_.characterEffect1054ui_story then
				arg_109_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_112_1 = 0
			local var_112_2 = 0.525

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_3 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(939012026).content)

				arg_109_1.text_.text = var_112_3

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_5 = 21 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 21)

				if (21 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_3) / 21)) > 0 and var_112_2 < var_112_5 then
					arg_109_1.talkMaxDuration = var_112_5

					if var_112_5 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_3
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_6 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_6 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_6

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_6 and arg_109_1.time_ < var_112_1 + var_112_6 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play939012027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 939012027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play939012028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1034ui_story = arg_113_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1034ui_story, Vector3.New(-0.7, -0.93, -6), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1034ui_story"].transform.position).z)
				arg_113_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1034ui_story"].transform.localEulerAngles = arg_113_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(-0.7, -0.93, -6)
				arg_113_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1034ui_story"].transform.position).z)
				arg_113_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1034ui_story"].transform.localEulerAngles = arg_113_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["1034ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1034ui_story == nil then
				arg_113_1.var_.characterEffect1034ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect1034ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1034ui_story then
				arg_113_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_116_4 = 0
			local var_116_5 = 0.2

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(939012027).content)

				arg_113_1.text_.text = var_116_6

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_8 = 8 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_6) / 8)

				if (8 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_6) / 8)) > 0 and var_116_5 < var_116_8 then
					arg_113_1.talkMaxDuration = var_116_8

					if var_116_8 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_6
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_9 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_9 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_9

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_9 and arg_113_1.time_ < var_116_4 + var_116_9 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play939012028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 939012028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play939012029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1054ui_story = arg_117_1.actors_["1054ui_story"].transform.localPosition

				local var_120_0 = GameObjectTools.GetOrAddComponent(arg_117_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_120_0 then
					var_120_0:EnableDynamicBone(false)
				end
			end

			local var_120_1 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_1 then
				arg_117_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_117_1.time_ - 0) / var_120_1)
				arg_117_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1054ui_story"].transform.position).z)
				arg_117_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1054ui_story"].transform.localEulerAngles = arg_117_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_1 and arg_117_1.time_ < 0 + var_120_1 + arg_120_0 then
				arg_117_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_117_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1054ui_story"].transform.position).z)
				arg_117_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1054ui_story"].transform.localEulerAngles = arg_117_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_120_2 = GameObjectTools.GetOrAddComponent(arg_117_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_120_2 then
					var_120_2:EnableDynamicBone(true)
				end
			end

			local var_120_3 = arg_117_1.actors_["1054ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_3) and arg_117_1.var_.characterEffect1054ui_story == nil then
				arg_117_1.var_.characterEffect1054ui_story = var_120_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_4 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 and not isNil(var_120_3) then
				if arg_117_1.var_.characterEffect1054ui_story and not isNil(var_120_3) then
					arg_117_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 and not isNil(var_120_3) and arg_117_1.var_.characterEffect1054ui_story then
				arg_117_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_120_6 = arg_117_1.actors_["1034ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_6) and arg_117_1.var_.characterEffect1034ui_story == nil then
				arg_117_1.var_.characterEffect1034ui_story = var_120_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_7 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 and not isNil(var_120_6) then
				if arg_117_1.var_.characterEffect1034ui_story and not isNil(var_120_6) then
					arg_117_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_7)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 and not isNil(var_120_6) and arg_117_1.var_.characterEffect1034ui_story then
				arg_117_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_120_8 = 0
			local var_120_9 = 0.275

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_8 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_10 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(939012028).content)

				arg_117_1.text_.text = var_120_10

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_12 = 11 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_10) / 11)

				if (11 <= 0 and var_120_9 or var_120_9 * (utf8.len(var_120_10) / 11)) > 0 and var_120_9 < var_120_12 then
					arg_117_1.talkMaxDuration = var_120_12

					if var_120_12 + var_120_8 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_8
					end
				end

				arg_117_1.text_.text = var_120_10
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_13 = math.max(var_120_9, arg_117_1.talkMaxDuration)

			if var_120_8 <= arg_117_1.time_ and arg_117_1.time_ < var_120_8 + var_120_13 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_8) / var_120_13

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_8 + var_120_13 and arg_117_1.time_ < var_120_8 + var_120_13 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play939012029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 939012029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play939012030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos6148ui_story = arg_121_1.actors_["6148ui_story"].transform.localPosition

				local var_124_0 = GameObjectTools.GetOrAddComponent(arg_121_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_124_0 then
					var_124_0:EnableDynamicBone(false)
				end
			end

			local var_124_1 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_1 then
				arg_121_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_121_1.time_ - 0) / var_124_1)
				arg_121_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["6148ui_story"].transform.position).z)
				arg_121_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["6148ui_story"].transform.localEulerAngles = arg_121_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_1 and arg_121_1.time_ < 0 + var_124_1 + arg_124_0 then
				arg_121_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_121_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["6148ui_story"].transform.position).z)
				arg_121_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["6148ui_story"].transform.localEulerAngles = arg_121_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_124_2 = GameObjectTools.GetOrAddComponent(arg_121_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_124_2 then
					var_124_2:EnableDynamicBone(true)
				end
			end

			local var_124_3 = arg_121_1.actors_["1054ui_story"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1054ui_story = var_124_3.localPosition

				local var_124_4 = GameObjectTools.GetOrAddComponent(var_124_3.gameObject, typeof(DynamicBoneHelper))

				if var_124_4 then
					var_124_4:EnableDynamicBone(false)
				end
			end

			local var_124_5 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_5 then
				var_124_3.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 0) / var_124_5)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_5 and arg_121_1.time_ < 0 + var_124_5 + arg_124_0 then
				var_124_3.localPosition = Vector3.New(0, 100, 0)
				var_124_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_3.position).x, (manager.ui.mainCamera.transform.position - var_124_3.position).y, (manager.ui.mainCamera.transform.position - var_124_3.position).z)
				var_124_3.localEulerAngles.z = 0
				var_124_3.localEulerAngles.x = 0
				var_124_3.localEulerAngles = var_124_3.localEulerAngles

				local var_124_6 = GameObjectTools.GetOrAddComponent(var_124_3.gameObject, typeof(DynamicBoneHelper))

				if var_124_6 then
					var_124_6:EnableDynamicBone(true)
				end
			end

			local var_124_7 = arg_121_1.actors_["6148ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_7) and arg_121_1.var_.characterEffect6148ui_story == nil then
				arg_121_1.var_.characterEffect6148ui_story = var_124_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_8 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_8 and not isNil(var_124_7) then
				if arg_121_1.var_.characterEffect6148ui_story and not isNil(var_124_7) then
					arg_121_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_8 and arg_121_1.time_ < 0 + var_124_8 + arg_124_0 and not isNil(var_124_7) and arg_121_1.var_.characterEffect6148ui_story then
				arg_121_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_124_10 = arg_121_1.actors_["1054ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_10) and arg_121_1.var_.characterEffect1054ui_story == nil then
				arg_121_1.var_.characterEffect1054ui_story = var_124_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_11 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_11 and not isNil(var_124_10) then
				if arg_121_1.var_.characterEffect1054ui_story and not isNil(var_124_10) then
					arg_121_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_11)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_11 and arg_121_1.time_ < 0 + var_124_11 + arg_124_0 and not isNil(var_124_10) and arg_121_1.var_.characterEffect1054ui_story then
				arg_121_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_124_12 = 0
			local var_124_13 = 0.925

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_12 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_14 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(939012029).content)

				arg_121_1.text_.text = var_124_14

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_16 = 37 <= 0 and var_124_13 or var_124_13 * (utf8.len(var_124_14) / 37)

				if (37 <= 0 and var_124_13 or var_124_13 * (utf8.len(var_124_14) / 37)) > 0 and var_124_13 < var_124_16 then
					arg_121_1.talkMaxDuration = var_124_16

					if var_124_16 + var_124_12 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_16 + var_124_12
					end
				end

				arg_121_1.text_.text = var_124_14
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_17 = math.max(var_124_13, arg_121_1.talkMaxDuration)

			if var_124_12 <= arg_121_1.time_ and arg_121_1.time_ < var_124_12 + var_124_17 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_12) / var_124_17

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_12 + var_124_17 and arg_121_1.time_ < var_124_12 + var_124_17 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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

		arg_121_1:InitPlayNodeList()
	end,
	Play939012030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 939012030
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play939012031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1034ui_story = arg_125_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1034ui_story, Vector3.New(-0.7, -0.93, -6), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1034ui_story"].transform.position).z)
				arg_125_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1034ui_story"].transform.localEulerAngles = arg_125_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(-0.7, -0.93, -6)
				arg_125_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1034ui_story"].transform.position).z)
				arg_125_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1034ui_story"].transform.localEulerAngles = arg_125_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["1034ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1034ui_story == nil then
				arg_125_1.var_.characterEffect1034ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1034ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1034ui_story then
				arg_125_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_128_4 = arg_125_1.actors_["6148ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect6148ui_story == nil then
				arg_125_1.var_.characterEffect6148ui_story = var_128_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_5 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_5 and not isNil(var_128_4) then
				if arg_125_1.var_.characterEffect6148ui_story and not isNil(var_128_4) then
					arg_125_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_125_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_5)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_5 and arg_125_1.time_ < 0 + var_128_5 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect6148ui_story then
				arg_125_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_125_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_2")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_128_6 = 0
			local var_128_7 = 1

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_8 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(939012030).content)

				arg_125_1.text_.text = var_128_8

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_10 = 40 <= 0 and var_128_7 or var_128_7 * (utf8.len(var_128_8) / 40)

				if (40 <= 0 and var_128_7 or var_128_7 * (utf8.len(var_128_8) / 40)) > 0 and var_128_7 < var_128_10 then
					arg_125_1.talkMaxDuration = var_128_10

					if var_128_10 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_10 + var_128_6
					end
				end

				arg_125_1.text_.text = var_128_8
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_11 = math.max(var_128_7, arg_125_1.talkMaxDuration)

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_11 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_6) / var_128_11

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_6 + var_128_11 and arg_125_1.time_ < var_128_6 + var_128_11 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play939012031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 939012031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play939012032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["1034ui_story"]) and arg_129_1.var_.characterEffect1034ui_story == nil then
				arg_129_1.var_.characterEffect1034ui_story = arg_129_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_0 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["1034ui_story"]) then
				if arg_129_1.var_.characterEffect1034ui_story and not isNil(arg_129_1.actors_["1034ui_story"]) then
					arg_129_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_0)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["1034ui_story"]) and arg_129_1.var_.characterEffect1034ui_story then
				arg_129_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_132_1 = 0
			local var_132_2 = 0.15

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(939012031).content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 6 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 6)

				if (6 <= 0 and var_132_2 or var_132_2 * (utf8.len(var_132_3) / 6)) > 0 and var_132_2 < var_132_5 then
					arg_129_1.talkMaxDuration = var_132_5

					if var_132_5 + var_132_1 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + var_132_1
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_6 = math.max(var_132_2, arg_129_1.talkMaxDuration)

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_6 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_1) / var_132_6

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_1 + var_132_6 and arg_129_1.time_ < var_132_1 + var_132_6 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play939012032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 939012032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play939012033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["1034ui_story"]) and arg_133_1.var_.characterEffect1034ui_story == nil then
				arg_133_1.var_.characterEffect1034ui_story = arg_133_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_0 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["1034ui_story"]) then
				if arg_133_1.var_.characterEffect1034ui_story and not isNil(arg_133_1.actors_["1034ui_story"]) then
					arg_133_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["1034ui_story"]) and arg_133_1.var_.characterEffect1034ui_story then
				arg_133_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_136_2 = 0
			local var_136_3 = 1.35

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_4 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(939012032).content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_6 = 54 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_4) / 54)

				if (54 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_4) / 54)) > 0 and var_136_3 < var_136_6 then
					arg_133_1.talkMaxDuration = var_136_6

					if var_136_6 + var_136_2 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_2
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_3, arg_133_1.talkMaxDuration)

			if var_136_2 <= arg_133_1.time_ and arg_133_1.time_ < var_136_2 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_2) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_2 + var_136_7 and arg_133_1.time_ < var_136_2 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play939012033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 939012033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play939012034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1034ui_story = arg_137_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1034ui_story, Vector3.New(-0.7, -0.93, -6), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1034ui_story"].transform.position).z)
				arg_137_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1034ui_story"].transform.localEulerAngles = arg_137_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(-0.7, -0.93, -6)
				arg_137_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1034ui_story"].transform.position).z)
				arg_137_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1034ui_story"].transform.localEulerAngles = arg_137_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_140_1 = 0
			local var_140_2 = 0.4

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(939012033).content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 16 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 16)

				if (16 <= 0 and var_140_2 or var_140_2 * (utf8.len(var_140_3) / 16)) > 0 and var_140_2 < var_140_5 then
					arg_137_1.talkMaxDuration = var_140_5

					if var_140_5 + var_140_1 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + var_140_1
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_6 = math.max(var_140_2, arg_137_1.talkMaxDuration)

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_6 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_1) / var_140_6

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_1 + var_140_6 and arg_137_1.time_ < var_140_1 + var_140_6 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play939012034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 939012034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play939012035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1034ui_story"]) and arg_141_1.var_.characterEffect1034ui_story == nil then
				arg_141_1.var_.characterEffect1034ui_story = arg_141_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1034ui_story"]) then
				if arg_141_1.var_.characterEffect1034ui_story and not isNil(arg_141_1.actors_["1034ui_story"]) then
					arg_141_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_0)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1034ui_story"]) and arg_141_1.var_.characterEffect1034ui_story then
				arg_141_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_144_1 = 0
			local var_144_2 = 0.25

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_3 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(939012034).content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 10 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 10)

				if (10 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 10)) > 0 and var_144_2 < var_144_5 then
					arg_141_1.talkMaxDuration = var_144_5

					if var_144_5 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + var_144_1
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_6 = math.max(var_144_2, arg_141_1.talkMaxDuration)

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_6 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_1) / var_144_6

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_1 + var_144_6 and arg_141_1.time_ < var_144_1 + var_144_6 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play939012035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 939012035
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play939012036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1034ui_story = arg_145_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1034ui_story"].transform.position).z)
				arg_145_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1034ui_story"].transform.localEulerAngles = arg_145_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1034ui_story"].transform.position).z)
				arg_145_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1034ui_story"].transform.localEulerAngles = arg_145_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["6148ui_story"].transform

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos6148ui_story = var_148_1.localPosition

				local var_148_2 = GameObjectTools.GetOrAddComponent(var_148_1.gameObject, typeof(DynamicBoneHelper))

				if var_148_2 then
					var_148_2:EnableDynamicBone(false)
				end
			end

			local var_148_3 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 then
				var_148_1.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_3)
				var_148_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_1.position).x, (manager.ui.mainCamera.transform.position - var_148_1.position).y, (manager.ui.mainCamera.transform.position - var_148_1.position).z)
				var_148_1.localEulerAngles.z = 0
				var_148_1.localEulerAngles.x = 0
				var_148_1.localEulerAngles = var_148_1.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 then
				var_148_1.localPosition = Vector3.New(0, 100, 0)
				var_148_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_148_1.position).x, (manager.ui.mainCamera.transform.position - var_148_1.position).y, (manager.ui.mainCamera.transform.position - var_148_1.position).z)
				var_148_1.localEulerAngles.z = 0
				var_148_1.localEulerAngles.x = 0
				var_148_1.localEulerAngles = var_148_1.localEulerAngles

				local var_148_4 = GameObjectTools.GetOrAddComponent(var_148_1.gameObject, typeof(DynamicBoneHelper))

				if var_148_4 then
					var_148_4:EnableDynamicBone(true)
				end
			end

			local var_148_5 = 0
			local var_148_6 = 0.725

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_7 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(939012035).content)

				arg_145_1.text_.text = var_148_7

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_9 = 29 <= 0 and var_148_6 or var_148_6 * (utf8.len(var_148_7) / 29)

				if (29 <= 0 and var_148_6 or var_148_6 * (utf8.len(var_148_7) / 29)) > 0 and var_148_6 < var_148_9 then
					arg_145_1.talkMaxDuration = var_148_9

					if var_148_9 + var_148_5 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_9 + var_148_5
					end
				end

				arg_145_1.text_.text = var_148_7
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_6, arg_145_1.talkMaxDuration)

			if var_148_5 <= arg_145_1.time_ and arg_145_1.time_ < var_148_5 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_5) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_5 + var_148_10 and arg_145_1.time_ < var_148_5 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
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

		arg_145_1:InitPlayNodeList()
	end,
	Play939012036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 939012036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play939012037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1034ui_story = arg_149_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1034ui_story"].transform.position).z)
				arg_149_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1034ui_story"].transform.localEulerAngles = arg_149_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, -0.93, -6)
				arg_149_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1034ui_story"].transform.position).z)
				arg_149_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1034ui_story"].transform.localEulerAngles = arg_149_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["1034ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1034ui_story == nil then
				arg_149_1.var_.characterEffect1034ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect1034ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1034ui_story then
				arg_149_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action4_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_152_4 = 0
			local var_152_5 = 1.275

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_6 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(939012036).content)

				arg_149_1.text_.text = var_152_6

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_8 = 51 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_6) / 51)

				if (51 <= 0 and var_152_5 or var_152_5 * (utf8.len(var_152_6) / 51)) > 0 and var_152_5 < var_152_8 then
					arg_149_1.talkMaxDuration = var_152_8

					if var_152_8 + var_152_4 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_8 + var_152_4
					end
				end

				arg_149_1.text_.text = var_152_6
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_9 = math.max(var_152_5, arg_149_1.talkMaxDuration)

			if var_152_4 <= arg_149_1.time_ and arg_149_1.time_ < var_152_4 + var_152_9 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_4) / var_152_9

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_4 + var_152_9 and arg_149_1.time_ < var_152_4 + var_152_9 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play939012037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 939012037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play939012038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["1034ui_story"]) and arg_153_1.var_.characterEffect1034ui_story == nil then
				arg_153_1.var_.characterEffect1034ui_story = arg_153_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_0 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["1034ui_story"]) then
				if arg_153_1.var_.characterEffect1034ui_story and not isNil(arg_153_1.actors_["1034ui_story"]) then
					arg_153_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_153_1.time_ - 0) / var_156_0)
				end
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["1034ui_story"]) and arg_153_1.var_.characterEffect1034ui_story then
				arg_153_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_156_1 = 0
			local var_156_2 = 0.325

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(939012037).content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_5 = 13 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 13)

				if (13 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_3) / 13)) > 0 and var_156_2 < var_156_5 then
					arg_153_1.talkMaxDuration = var_156_5

					if var_156_5 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + var_156_1
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_6 = math.max(var_156_2, arg_153_1.talkMaxDuration)

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_6 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_1) / var_156_6

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_1 + var_156_6 and arg_153_1.time_ < var_156_1 + var_156_6 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play939012038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 939012038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play939012039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1034ui_story = arg_157_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1034ui_story"].transform.position).z)
				arg_157_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1034ui_story"].transform.localEulerAngles = arg_157_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, -0.93, -6)
				arg_157_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1034ui_story"].transform.position).z)
				arg_157_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1034ui_story"].transform.localEulerAngles = arg_157_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["1034ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1034ui_story == nil then
				arg_157_1.var_.characterEffect1034ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect1034ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1034ui_story then
				arg_157_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action447")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_160_4 = 0
			local var_160_5 = 0.5

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_6 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(939012038).content)

				arg_157_1.text_.text = var_160_6

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_8 = 20 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_6) / 20)

				if (20 <= 0 and var_160_5 or var_160_5 * (utf8.len(var_160_6) / 20)) > 0 and var_160_5 < var_160_8 then
					arg_157_1.talkMaxDuration = var_160_8

					if var_160_8 + var_160_4 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_4
					end
				end

				arg_157_1.text_.text = var_160_6
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_9 = math.max(var_160_5, arg_157_1.talkMaxDuration)

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_9 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_4) / var_160_9

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_4 + var_160_9 and arg_157_1.time_ < var_160_4 + var_160_9 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play939012039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 939012039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play939012040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos6148ui_story = arg_161_1.actors_["6148ui_story"].transform.localPosition

				local var_164_0 = GameObjectTools.GetOrAddComponent(arg_161_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_164_0 then
					var_164_0:EnableDynamicBone(false)
				end
			end

			local var_164_1 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_1 then
				arg_161_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_161_1.time_ - 0) / var_164_1)
				arg_161_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["6148ui_story"].transform.position).z)
				arg_161_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["6148ui_story"].transform.localEulerAngles = arg_161_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_1 and arg_161_1.time_ < 0 + var_164_1 + arg_164_0 then
				arg_161_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_161_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["6148ui_story"].transform.position).z)
				arg_161_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["6148ui_story"].transform.localEulerAngles = arg_161_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_164_2 = GameObjectTools.GetOrAddComponent(arg_161_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_164_2 then
					var_164_2:EnableDynamicBone(true)
				end
			end

			local var_164_3 = arg_161_1.actors_["1034ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1034ui_story = var_164_3.localPosition
			end

			local var_164_4 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				var_164_3.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1034ui_story, Vector3.New(-0.7, -0.93, -6), (arg_161_1.time_ - 0) / var_164_4)
				var_164_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_3.position).x, (manager.ui.mainCamera.transform.position - var_164_3.position).y, (manager.ui.mainCamera.transform.position - var_164_3.position).z)
				var_164_3.localEulerAngles.z = 0
				var_164_3.localEulerAngles.x = 0
				var_164_3.localEulerAngles = var_164_3.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				var_164_3.localPosition = Vector3.New(-0.7, -0.93, -6)
				var_164_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_3.position).x, (manager.ui.mainCamera.transform.position - var_164_3.position).y, (manager.ui.mainCamera.transform.position - var_164_3.position).z)
				var_164_3.localEulerAngles.z = 0
				var_164_3.localEulerAngles.x = 0
				var_164_3.localEulerAngles = var_164_3.localEulerAngles
			end

			local var_164_5 = arg_161_1.actors_["6148ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect6148ui_story == nil then
				arg_161_1.var_.characterEffect6148ui_story = var_164_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_6 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_6 and not isNil(var_164_5) then
				if arg_161_1.var_.characterEffect6148ui_story and not isNil(var_164_5) then
					arg_161_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_6 and arg_161_1.time_ < 0 + var_164_6 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect6148ui_story then
				arg_161_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_164_8 = arg_161_1.actors_["1034ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.characterEffect1034ui_story == nil then
				arg_161_1.var_.characterEffect1034ui_story = var_164_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_9 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_9 and not isNil(var_164_8) then
				if arg_161_1.var_.characterEffect1034ui_story and not isNil(var_164_8) then
					arg_161_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_9)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_9 and arg_161_1.time_ < 0 + var_164_9 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.characterEffect1034ui_story then
				arg_161_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_164_10 = 0
			local var_164_11 = 0.375

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_12 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(939012039).content)

				arg_161_1.text_.text = var_164_12

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_14 = 15 <= 0 and var_164_11 or var_164_11 * (utf8.len(var_164_12) / 15)

				if (15 <= 0 and var_164_11 or var_164_11 * (utf8.len(var_164_12) / 15)) > 0 and var_164_11 < var_164_14 then
					arg_161_1.talkMaxDuration = var_164_14

					if var_164_14 + var_164_10 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_14 + var_164_10
					end
				end

				arg_161_1.text_.text = var_164_12
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_15 = math.max(var_164_11, arg_161_1.talkMaxDuration)

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_15 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_10) / var_164_15

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_10 + var_164_15 and arg_161_1.time_ < var_164_10 + var_164_15 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
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
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play939012040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 939012040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play939012041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1034ui_story = arg_165_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1034ui_story, Vector3.New(-0.7, -0.93, -6), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1034ui_story"].transform.position).z)
				arg_165_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1034ui_story"].transform.localEulerAngles = arg_165_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(-0.7, -0.93, -6)
				arg_165_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1034ui_story"].transform.position).z)
				arg_165_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1034ui_story"].transform.localEulerAngles = arg_165_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1034ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1034ui_story == nil then
				arg_165_1.var_.characterEffect1034ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1034ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1034ui_story then
				arg_165_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_168_4 = arg_165_1.actors_["6148ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect6148ui_story == nil then
				arg_165_1.var_.characterEffect6148ui_story = var_168_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_5 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_5 and not isNil(var_168_4) then
				if arg_165_1.var_.characterEffect6148ui_story and not isNil(var_168_4) then
					arg_165_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_165_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_5)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_5 and arg_165_1.time_ < 0 + var_168_5 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect6148ui_story then
				arg_165_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_165_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_2")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_168_6 = 0
			local var_168_7 = 0.375

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(939012040).content)

				arg_165_1.text_.text = var_168_8

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 15 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_8) / 15)

				if (15 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_8) / 15)) > 0 and var_168_7 < var_168_10 then
					arg_165_1.talkMaxDuration = var_168_10

					if var_168_10 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_8
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_11 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_11 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_11

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_11 and arg_165_1.time_ < var_168_6 + var_168_11 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play939012041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 939012041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play939012042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1034ui_story = arg_169_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1034ui_story"].transform.position).z)
				arg_169_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1034ui_story"].transform.localEulerAngles = arg_169_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_169_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1034ui_story"].transform.position).z)
				arg_169_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1034ui_story"].transform.localEulerAngles = arg_169_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_172_1 = arg_169_1.actors_["6148ui_story"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos6148ui_story = var_172_1.localPosition

				local var_172_2 = GameObjectTools.GetOrAddComponent(var_172_1.gameObject, typeof(DynamicBoneHelper))

				if var_172_2 then
					var_172_2:EnableDynamicBone(false)
				end
			end

			local var_172_3 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_3 then
				var_172_1.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_169_1.time_ - 0) / var_172_3)
				var_172_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_1.position).x, (manager.ui.mainCamera.transform.position - var_172_1.position).y, (manager.ui.mainCamera.transform.position - var_172_1.position).z)
				var_172_1.localEulerAngles.z = 0
				var_172_1.localEulerAngles.x = 0
				var_172_1.localEulerAngles = var_172_1.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_3 and arg_169_1.time_ < 0 + var_172_3 + arg_172_0 then
				var_172_1.localPosition = Vector3.New(0, 100, 0)
				var_172_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_172_1.position).x, (manager.ui.mainCamera.transform.position - var_172_1.position).y, (manager.ui.mainCamera.transform.position - var_172_1.position).z)
				var_172_1.localEulerAngles.z = 0
				var_172_1.localEulerAngles.x = 0
				var_172_1.localEulerAngles = var_172_1.localEulerAngles

				local var_172_4 = GameObjectTools.GetOrAddComponent(var_172_1.gameObject, typeof(DynamicBoneHelper))

				if var_172_4 then
					var_172_4:EnableDynamicBone(true)
				end
			end

			local var_172_5 = arg_169_1.actors_["1034ui_story"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.characterEffect1034ui_story == nil then
				arg_169_1.var_.characterEffect1034ui_story = var_172_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_6 = 0.200000002980232

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_6 and not isNil(var_172_5) then
				if arg_169_1.var_.characterEffect1034ui_story and not isNil(var_172_5) then
					arg_169_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_169_1.time_ - 0) / var_172_6)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_6 and arg_169_1.time_ < 0 + var_172_6 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.characterEffect1034ui_story then
				arg_169_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_172_7 = 0
			local var_172_8 = 0.475

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_7 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_9 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(939012041).content)

				arg_169_1.text_.text = var_172_9

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_11 = 19 <= 0 and var_172_8 or var_172_8 * (utf8.len(var_172_9) / 19)

				if (19 <= 0 and var_172_8 or var_172_8 * (utf8.len(var_172_9) / 19)) > 0 and var_172_8 < var_172_11 then
					arg_169_1.talkMaxDuration = var_172_11

					if var_172_11 + var_172_7 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_11 + var_172_7
					end
				end

				arg_169_1.text_.text = var_172_9
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_12 = math.max(var_172_8, arg_169_1.talkMaxDuration)

			if var_172_7 <= arg_169_1.time_ and arg_169_1.time_ < var_172_7 + var_172_12 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_7) / var_172_12

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_7 + var_172_12 and arg_169_1.time_ < var_172_7 + var_172_12 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
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

		arg_169_1:InitPlayNodeList()
	end,
	Play939012042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 939012042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play939012043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1034ui_story = arg_173_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1034ui_story"].transform.position).z)
				arg_173_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1034ui_story"].transform.localEulerAngles = arg_173_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, -0.93, -6)
				arg_173_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1034ui_story"].transform.position).z)
				arg_173_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1034ui_story"].transform.localEulerAngles = arg_173_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1034ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1034ui_story == nil then
				arg_173_1.var_.characterEffect1034ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1034ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1034ui_story then
				arg_173_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_176_4 = 0
			local var_176_5 = 0.15

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(939012042).content)

				arg_173_1.text_.text = var_176_6

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_8 = 6 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_6) / 6)

				if (6 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_6) / 6)) > 0 and var_176_5 < var_176_8 then
					arg_173_1.talkMaxDuration = var_176_8

					if var_176_8 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_6
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_9 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_9 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_9

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_9 and arg_173_1.time_ < var_176_4 + var_176_9 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play939012043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 939012043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play939012044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if arg_177_1.actors_["1012ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1012ui_story"))) then
				local var_180_0 = Object.Instantiate(Asset.Load("Char/" .. "1012ui_story"), arg_177_1.stage_.transform)

				var_180_0.name = "1012ui_story"
				var_180_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_177_1.actors_["1012ui_story"] = var_180_0

				local var_180_1 = var_180_0:GetComponentInChildren(typeof(CharacterEffect))

				var_180_1.enabled = true

				local var_180_2 = GameObjectTools.GetOrAddComponent(var_180_0, typeof(DynamicBoneHelper))

				if var_180_2 then
					var_180_2:EnableDynamicBone(false)
				end

				arg_177_1:ShowWeapon(var_180_1.transform, false)

				arg_177_1.var_["1012ui_story" .. "Animator"] = var_180_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_177_1.var_["1012ui_story" .. "Animator"].applyRootMotion = true
				arg_177_1.var_["1012ui_story" .. "LipSync"] = var_180_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_180_3 = arg_177_1.actors_["1012ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_3) and arg_177_1.var_.characterEffect1012ui_story == nil then
				arg_177_1.var_.characterEffect1012ui_story = var_180_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_4 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_4 and not isNil(var_180_3) then
				if arg_177_1.var_.characterEffect1012ui_story and not isNil(var_180_3) then
					arg_177_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_4 and arg_177_1.time_ < 0 + var_180_4 + arg_180_0 and not isNil(var_180_3) and arg_177_1.var_.characterEffect1012ui_story then
				arg_177_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_180_6 = arg_177_1.actors_["1034ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect1034ui_story == nil then
				arg_177_1.var_.characterEffect1034ui_story = var_180_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_7 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 and not isNil(var_180_6) then
				if arg_177_1.var_.characterEffect1034ui_story and not isNil(var_180_6) then
					arg_177_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_7)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 and not isNil(var_180_6) and arg_177_1.var_.characterEffect1034ui_story then
				arg_177_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_180_8 = 0
			local var_180_9 = 0.425

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_8 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1012")

				arg_177_1.callingController_:SetSelectedState("calling")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_10 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(939012043).content)

				arg_177_1.text_.text = var_180_10

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_12 = 17 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_10) / 17)

				if (17 <= 0 and var_180_9 or var_180_9 * (utf8.len(var_180_10) / 17)) > 0 and var_180_9 < var_180_12 then
					arg_177_1.talkMaxDuration = var_180_12

					if var_180_12 + var_180_8 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_12 + var_180_8
					end
				end

				arg_177_1.text_.text = var_180_10
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_13 = math.max(var_180_9, arg_177_1.talkMaxDuration)

			if var_180_8 <= arg_177_1.time_ and arg_177_1.time_ < var_180_8 + var_180_13 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_8) / var_180_13

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_8 + var_180_13 and arg_177_1.time_ < var_180_8 + var_180_13 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play939012044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 939012044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play939012045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1034ui_story = arg_181_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1034ui_story"].transform.position).z)
				arg_181_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1034ui_story"].transform.localEulerAngles = arg_181_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, -0.93, -6)
				arg_181_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1034ui_story"].transform.position).z)
				arg_181_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1034ui_story"].transform.localEulerAngles = arg_181_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["1034ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1034ui_story == nil then
				arg_181_1.var_.characterEffect1034ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1034ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1034ui_story then
				arg_181_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_184_4 = arg_181_1.actors_["1012ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect1012ui_story == nil then
				arg_181_1.var_.characterEffect1012ui_story = var_184_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_5 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_5 and not isNil(var_184_4) then
				if arg_181_1.var_.characterEffect1012ui_story and not isNil(var_184_4) then
					arg_181_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_5)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_5 and arg_181_1.time_ < 0 + var_184_5 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect1012ui_story then
				arg_181_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_1")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_184_6 = 0
			local var_184_7 = 0.75

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_8 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(939012044).content)

				arg_181_1.text_.text = var_184_8

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_10 = 30 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_8) / 30)

				if (30 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_8) / 30)) > 0 and var_184_7 < var_184_10 then
					arg_181_1.talkMaxDuration = var_184_10

					if var_184_10 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_10 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_8
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_11 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_11 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_11

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_11 and arg_181_1.time_ < var_184_6 + var_184_11 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play939012045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 939012045
		arg_185_1.duration_ = 9

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play939012046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 2 < arg_185_1.time_ and arg_185_1.time_ <= 2 + arg_188_0 then
				local var_188_0 = arg_185_1.bgs_.I05a

				arg_185_1.bgs_.I05a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_188_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_188_1 = var_188_0:GetComponent("SpriteRenderer")

				if var_188_1 and var_188_1.sprite then
					local var_188_2 = 2 * (var_188_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_188_0.transform.localScale = Vector3.New(var_188_2 / var_188_1.sprite.bounds.size.y < var_188_2 * manager.ui.mainCameraCom_.aspect / var_188_1.sprite.bounds.size.x and var_188_2 * manager.ui.mainCameraCom_.aspect / var_188_1.sprite.bounds.size.x or var_188_2 / var_188_1.sprite.bounds.size.y, var_188_2 / var_188_1.sprite.bounds.size.y < var_188_2 * manager.ui.mainCameraCom_.aspect / var_188_1.sprite.bounds.size.x and var_188_2 * manager.ui.mainCameraCom_.aspect / var_188_1.sprite.bounds.size.x or var_188_2 / var_188_1.sprite.bounds.size.y, 0)
				end

				for iter_188_0, iter_188_1 in pairs(arg_185_1.bgs_) do
					if iter_188_0 ~= "I05a" then
						iter_188_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_188_3 = 3.9666666696469

			if 3.9666666696469 < arg_185_1.time_ and arg_185_1.time_ <= var_188_3 + arg_188_0 then
				arg_185_1.allBtn_.enabled = false
			end

			if arg_185_1.time_ >= var_188_3 + 0.3 and arg_185_1.time_ < var_188_3 + 0.3 + arg_188_0 then
				arg_185_1.allBtn_.enabled = true
			end

			local var_188_4 = 0

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_5 = 2

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_5 then
				local var_188_6 = Color.New(0, 0, 0)

				var_188_6.a = Mathf.Lerp(0, 1, (arg_185_1.time_ - var_188_4) / var_188_5)
				arg_185_1.mask_.color = var_188_6
			end

			if arg_185_1.time_ >= var_188_4 + var_188_5 and arg_185_1.time_ < var_188_4 + var_188_5 + arg_188_0 then
				local var_188_7 = Color.New(0, 0, 0)

				var_188_7.a = 1
				arg_185_1.mask_.color = var_188_7
			end

			local var_188_8 = 2

			if 2 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.mask_.enabled = true
				arg_185_1.mask_.raycastTarget = true

				arg_185_1:SetGaussion(false)
			end

			local var_188_9 = 2

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_9 then
				local var_188_10 = Color.New(0, 0, 0)

				var_188_10.a = Mathf.Lerp(1, 0, (arg_185_1.time_ - var_188_8) / var_188_9)
				arg_185_1.mask_.color = var_188_10
			end

			if arg_185_1.time_ >= var_188_8 + var_188_9 and arg_185_1.time_ < var_188_8 + var_188_9 + arg_188_0 then
				local var_188_11 = Color.New(0, 0, 0)

				arg_185_1.mask_.enabled = false
				var_188_11.a = 0
				arg_185_1.mask_.color = var_188_11
			end

			local var_188_12 = arg_185_1.actors_["1034ui_story"].transform

			if 1.96599999815226 < arg_185_1.time_ and arg_185_1.time_ <= 1.96599999815226 + arg_188_0 then
				arg_185_1.var_.moveOldPos1034ui_story = var_188_12.localPosition
			end

			local var_188_13 = 0.001

			if 1.96599999815226 <= arg_185_1.time_ and arg_185_1.time_ < 1.96599999815226 + var_188_13 then
				var_188_12.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_185_1.time_ - 1.96599999815226) / var_188_13)
				var_188_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_12.position).x, (manager.ui.mainCamera.transform.position - var_188_12.position).y, (manager.ui.mainCamera.transform.position - var_188_12.position).z)
				var_188_12.localEulerAngles.z = 0
				var_188_12.localEulerAngles.x = 0
				var_188_12.localEulerAngles = var_188_12.localEulerAngles
			end

			if arg_185_1.time_ >= 1.96599999815226 + var_188_13 and arg_185_1.time_ < 1.96599999815226 + var_188_13 + arg_188_0 then
				var_188_12.localPosition = Vector3.New(0, 100, 0)
				var_188_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_12.position).x, (manager.ui.mainCamera.transform.position - var_188_12.position).y, (manager.ui.mainCamera.transform.position - var_188_12.position).z)
				var_188_12.localEulerAngles.z = 0
				var_188_12.localEulerAngles.x = 0
				var_188_12.localEulerAngles = var_188_12.localEulerAngles
			end

			local var_188_14 = arg_185_1.actors_["1012ui_story"].transform

			if 3.76666666666667 < arg_185_1.time_ and arg_185_1.time_ <= 3.76666666666667 + arg_188_0 then
				arg_185_1.var_.moveOldPos1012ui_story = var_188_14.localPosition
			end

			local var_188_15 = 0.001

			if 3.76666666666667 <= arg_185_1.time_ and arg_185_1.time_ < 3.76666666666667 + var_188_15 then
				var_188_14.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_185_1.time_ - 3.76666666666667) / var_188_15)
				var_188_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_14.position).x, (manager.ui.mainCamera.transform.position - var_188_14.position).y, (manager.ui.mainCamera.transform.position - var_188_14.position).z)
				var_188_14.localEulerAngles.z = 0
				var_188_14.localEulerAngles.x = 0
				var_188_14.localEulerAngles = var_188_14.localEulerAngles
			end

			if arg_185_1.time_ >= 3.76666666666667 + var_188_15 and arg_185_1.time_ < 3.76666666666667 + var_188_15 + arg_188_0 then
				var_188_14.localPosition = Vector3.New(0, -1.05, -6.24)
				var_188_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_188_14.position).x, (manager.ui.mainCamera.transform.position - var_188_14.position).y, (manager.ui.mainCamera.transform.position - var_188_14.position).z)
				var_188_14.localEulerAngles.z = 0
				var_188_14.localEulerAngles.x = 0
				var_188_14.localEulerAngles = var_188_14.localEulerAngles
			end

			local var_188_16 = arg_185_1.actors_["1012ui_story"]

			if 3.76666666666667 < arg_185_1.time_ and arg_185_1.time_ <= 3.76666666666667 + arg_188_0 and not isNil(var_188_16) and arg_185_1.var_.characterEffect1012ui_story == nil then
				arg_185_1.var_.characterEffect1012ui_story = var_188_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_17 = 0.200000002980232

			if 3.76666666666667 <= arg_185_1.time_ and arg_185_1.time_ < 3.76666666666667 + var_188_17 and not isNil(var_188_16) then
				if arg_185_1.var_.characterEffect1012ui_story and not isNil(var_188_16) then
					arg_185_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 3.76666666666667 + var_188_17 and arg_185_1.time_ < 3.76666666666667 + var_188_17 + arg_188_0 and not isNil(var_188_16) and arg_185_1.var_.characterEffect1012ui_story then
				arg_185_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_188_19 = arg_185_1.actors_["1034ui_story"]

			if 3.76666666666667 < arg_185_1.time_ and arg_185_1.time_ <= 3.76666666666667 + arg_188_0 and not isNil(var_188_19) and arg_185_1.var_.characterEffect1034ui_story == nil then
				arg_185_1.var_.characterEffect1034ui_story = var_188_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_20 = 0.200000002980232

			if 3.76666666666667 <= arg_185_1.time_ and arg_185_1.time_ < 3.76666666666667 + var_188_20 and not isNil(var_188_19) then
				if arg_185_1.var_.characterEffect1034ui_story and not isNil(var_188_19) then
					arg_185_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_185_1.time_ - 3.76666666666667) / var_188_20)
				end
			end

			if arg_185_1.time_ >= 3.76666666666667 + var_188_20 and arg_185_1.time_ < 3.76666666666667 + var_188_20 + arg_188_0 and not isNil(var_188_19) and arg_185_1.var_.characterEffect1034ui_story then
				arg_185_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 3.76666666666667 < arg_185_1.time_ and arg_185_1.time_ <= 3.76666666666667 + arg_188_0 then
				arg_185_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			if 3.76666666666667 < arg_185_1.time_ and arg_185_1.time_ <= 3.76666666666667 + arg_188_0 then
				arg_185_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			if arg_185_1.frameCnt_ <= 1 then
				arg_185_1.dialog_:SetActive(false)
			end

			local var_188_21 = 4
			local var_188_22 = 0.85

			if 4 < arg_185_1.time_ and arg_185_1.time_ <= var_188_21 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0

				arg_185_1.dialog_:SetActive(true)

				arg_185_1.dialogCg_.alpha = 0

				local var_188_23 = LeanTween.value(arg_185_1.dialog_, 0, 1, 0.3)

				var_188_23:setOnUpdate(LuaHelper.FloatAction(function(arg_189_0)
					arg_185_1.dialogCg_.alpha = arg_189_0
				end))
				var_188_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_185_1.dialog_)
					var_188_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_185_1.duration_ = arg_185_1.duration_ + 0.3

				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_24 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(939012045).content)

				arg_185_1.text_.text = var_188_24

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_26 = 34 <= 0 and var_188_22 or var_188_22 * (utf8.len(var_188_24) / 34)

				if (34 <= 0 and var_188_22 or var_188_22 * (utf8.len(var_188_24) / 34)) > 0 and var_188_22 < var_188_26 then
					arg_185_1.talkMaxDuration = var_188_26
					var_188_21 = var_188_21 + 0.3

					if var_188_26 + var_188_21 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_26 + var_188_21
					end
				end

				arg_185_1.text_.text = var_188_24
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_27 = var_188_21 + 0.3
			local var_188_28 = math.max(var_188_22, arg_185_1.talkMaxDuration)

			if var_188_21 + 0.3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_27 + var_188_28 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_27) / var_188_28

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_27 + var_188_28 and arg_185_1.time_ < var_188_27 + var_188_28 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.76666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play939012046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 939012046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play939012047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1012ui_story = arg_191_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1012ui_story, Vector3.New(0, -1.05, -6.24), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1012ui_story"].transform.position).z)
				arg_191_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1012ui_story"].transform.localEulerAngles = arg_191_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, -1.05, -6.24)
				arg_191_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1012ui_story"].transform.position).z)
				arg_191_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1012ui_story"].transform.localEulerAngles = arg_191_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action2_1")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_194_1 = 0
			local var_194_2 = 0.6

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_3 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(939012046).content)

				arg_191_1.text_.text = var_194_3

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 24 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 24)

				if (24 <= 0 and var_194_2 or var_194_2 * (utf8.len(var_194_3) / 24)) > 0 and var_194_2 < var_194_5 then
					arg_191_1.talkMaxDuration = var_194_5

					if var_194_5 + var_194_1 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + var_194_1
					end
				end

				arg_191_1.text_.text = var_194_3
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_6 = math.max(var_194_2, arg_191_1.talkMaxDuration)

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_6 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_1) / var_194_6

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_1 + var_194_6 and arg_191_1.time_ < var_194_1 + var_194_6 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play939012047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 939012047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play939012048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1012ui_story = arg_195_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1012ui_story"].transform.position).z)
				arg_195_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1012ui_story"].transform.localEulerAngles = arg_195_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_195_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["1012ui_story"].transform.position).z)
				arg_195_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["1012ui_story"].transform.localEulerAngles = arg_195_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_198_1 = arg_195_1.actors_["1012ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1012ui_story == nil then
				arg_195_1.var_.characterEffect1012ui_story = var_198_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 and not isNil(var_198_1) then
				if arg_195_1.var_.characterEffect1012ui_story and not isNil(var_198_1) then
					arg_195_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_2)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect1012ui_story then
				arg_195_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_198_3 = 0
			local var_198_4 = 1.025

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_3 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_5 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(939012047).content)

				arg_195_1.text_.text = var_198_5

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_7 = 41 <= 0 and var_198_4 or var_198_4 * (utf8.len(var_198_5) / 41)

				if (41 <= 0 and var_198_4 or var_198_4 * (utf8.len(var_198_5) / 41)) > 0 and var_198_4 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_3 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_3
					end
				end

				arg_195_1.text_.text = var_198_5
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_8 = math.max(var_198_4, arg_195_1.talkMaxDuration)

			if var_198_3 <= arg_195_1.time_ and arg_195_1.time_ < var_198_3 + var_198_8 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_3) / var_198_8

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_3 + var_198_8 and arg_195_1.time_ < var_198_3 + var_198_8 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play939012048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 939012048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play939012049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1034ui_story = arg_199_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1034ui_story, Vector3.New(0, -0.93, -6), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1034ui_story"].transform.position).z)
				arg_199_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1034ui_story"].transform.localEulerAngles = arg_199_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0, -0.93, -6)
				arg_199_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1034ui_story"].transform.position).z)
				arg_199_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1034ui_story"].transform.localEulerAngles = arg_199_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["1034ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1034ui_story == nil then
				arg_199_1.var_.characterEffect1034ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect1034ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect1034ui_story then
				arg_199_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action3_1")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_202_4 = 0
			local var_202_5 = 0.6

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_6 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(939012048).content)

				arg_199_1.text_.text = var_202_6

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_8 = 24 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_6) / 24)

				if (24 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_6) / 24)) > 0 and var_202_5 < var_202_8 then
					arg_199_1.talkMaxDuration = var_202_8

					if var_202_8 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_6
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_9 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_9 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_9

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_9 and arg_199_1.time_ < var_202_4 + var_202_9 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play939012049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 939012049
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play939012050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1034ui_story"]) and arg_203_1.var_.characterEffect1034ui_story == nil then
				arg_203_1.var_.characterEffect1034ui_story = arg_203_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1034ui_story"]) then
				if arg_203_1.var_.characterEffect1034ui_story and not isNil(arg_203_1.actors_["1034ui_story"]) then
					arg_203_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_203_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_0)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1034ui_story"]) and arg_203_1.var_.characterEffect1034ui_story then
				arg_203_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_203_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_206_1 = 0
			local var_206_2 = 0.5

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_3 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(939012049).content)

				arg_203_1.text_.text = var_206_3

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 20 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_3) / 20)

				if (20 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_3) / 20)) > 0 and var_206_2 < var_206_5 then
					arg_203_1.talkMaxDuration = var_206_5

					if var_206_5 + var_206_1 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + var_206_1
					end
				end

				arg_203_1.text_.text = var_206_3
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_6 = math.max(var_206_2, arg_203_1.talkMaxDuration)

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_6 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_1) / var_206_6

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_1 + var_206_6 and arg_203_1.time_ < var_206_1 + var_206_6 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play939012050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 939012050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play939012051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0.425

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_1 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(939012050).content)

				arg_207_1.text_.text = var_210_1

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_3 = 17 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 17)

				if (17 <= 0 and var_210_0 or var_210_0 * (utf8.len(var_210_1) / 17)) > 0 and var_210_0 < var_210_3 then
					arg_207_1.talkMaxDuration = var_210_3

					if var_210_3 + 0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_3 + 0
					end
				end

				arg_207_1.text_.text = var_210_1
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_4 = math.max(var_210_0, arg_207_1.talkMaxDuration)

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - 0) / var_210_4

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play939012051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 939012051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play939012052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if arg_211_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_214_0 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_211_1.stage_.transform)

				var_214_0.name = "1284ui_story"
				var_214_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["1284ui_story"] = var_214_0

				local var_214_1 = var_214_0:GetComponentInChildren(typeof(CharacterEffect))

				var_214_1.enabled = true

				local var_214_2 = GameObjectTools.GetOrAddComponent(var_214_0, typeof(DynamicBoneHelper))

				if var_214_2 then
					var_214_2:EnableDynamicBone(false)
				end

				arg_211_1:ShowWeapon(var_214_1.transform, false)

				arg_211_1.var_["1284ui_story" .. "Animator"] = var_214_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_211_1.var_["1284ui_story" .. "Animator"].applyRootMotion = true
				arg_211_1.var_["1284ui_story" .. "LipSync"] = var_214_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_214_3 = arg_211_1.actors_["1284ui_story"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1284ui_story = var_214_3.localPosition
			end

			local var_214_4 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				var_214_3.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_211_1.time_ - 0) / var_214_4)
				var_214_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_3.position).x, (manager.ui.mainCamera.transform.position - var_214_3.position).y, (manager.ui.mainCamera.transform.position - var_214_3.position).z)
				var_214_3.localEulerAngles.z = 0
				var_214_3.localEulerAngles.x = 0
				var_214_3.localEulerAngles = var_214_3.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				var_214_3.localPosition = Vector3.New(0.7, -0.985, -6.22)
				var_214_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_3.position).x, (manager.ui.mainCamera.transform.position - var_214_3.position).y, (manager.ui.mainCamera.transform.position - var_214_3.position).z)
				var_214_3.localEulerAngles.z = 0
				var_214_3.localEulerAngles.x = 0
				var_214_3.localEulerAngles = var_214_3.localEulerAngles
			end

			local var_214_5 = arg_211_1.actors_["1034ui_story"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1034ui_story = var_214_5.localPosition
			end

			local var_214_6 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_6 then
				var_214_5.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1034ui_story, Vector3.New(-0.7, -0.93, -6), (arg_211_1.time_ - 0) / var_214_6)
				var_214_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_5.position).x, (manager.ui.mainCamera.transform.position - var_214_5.position).y, (manager.ui.mainCamera.transform.position - var_214_5.position).z)
				var_214_5.localEulerAngles.z = 0
				var_214_5.localEulerAngles.x = 0
				var_214_5.localEulerAngles = var_214_5.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_6 and arg_211_1.time_ < 0 + var_214_6 + arg_214_0 then
				var_214_5.localPosition = Vector3.New(-0.7, -0.93, -6)
				var_214_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_5.position).x, (manager.ui.mainCamera.transform.position - var_214_5.position).y, (manager.ui.mainCamera.transform.position - var_214_5.position).z)
				var_214_5.localEulerAngles.z = 0
				var_214_5.localEulerAngles.x = 0
				var_214_5.localEulerAngles = var_214_5.localEulerAngles
			end

			local var_214_7 = arg_211_1.actors_["1284ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_7) and arg_211_1.var_.characterEffect1284ui_story == nil then
				arg_211_1.var_.characterEffect1284ui_story = var_214_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_8 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_8 and not isNil(var_214_7) then
				if arg_211_1.var_.characterEffect1284ui_story and not isNil(var_214_7) then
					arg_211_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_8 and arg_211_1.time_ < 0 + var_214_8 + arg_214_0 and not isNil(var_214_7) and arg_211_1.var_.characterEffect1284ui_story then
				arg_211_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_214_10 = 0
			local var_214_11 = 0.475

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_10 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_12 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(939012051).content)

				arg_211_1.text_.text = var_214_12

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_14 = 19 <= 0 and var_214_11 or var_214_11 * (utf8.len(var_214_12) / 19)

				if (19 <= 0 and var_214_11 or var_214_11 * (utf8.len(var_214_12) / 19)) > 0 and var_214_11 < var_214_14 then
					arg_211_1.talkMaxDuration = var_214_14

					if var_214_14 + var_214_10 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_14 + var_214_10
					end
				end

				arg_211_1.text_.text = var_214_12
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_15 = math.max(var_214_11, arg_211_1.talkMaxDuration)

			if var_214_10 <= arg_211_1.time_ and arg_211_1.time_ < var_214_10 + var_214_15 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_10) / var_214_15

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_10 + var_214_15 and arg_211_1.time_ < var_214_10 + var_214_15 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
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
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play939012052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 939012052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play939012053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1034ui_story = arg_215_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1034ui_story, Vector3.New(-0.7, -0.93, -6), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1034ui_story"].transform.position).z)
				arg_215_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1034ui_story"].transform.localEulerAngles = arg_215_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(-0.7, -0.93, -6)
				arg_215_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["1034ui_story"].transform.position).z)
				arg_215_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["1034ui_story"].transform.localEulerAngles = arg_215_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["1034ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1034ui_story == nil then
				arg_215_1.var_.characterEffect1034ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect1034ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect1034ui_story then
				arg_215_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_218_4 = arg_215_1.actors_["1284ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_4) and arg_215_1.var_.characterEffect1284ui_story == nil then
				arg_215_1.var_.characterEffect1284ui_story = var_218_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_5 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_5 and not isNil(var_218_4) then
				if arg_215_1.var_.characterEffect1284ui_story and not isNil(var_218_4) then
					arg_215_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_215_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_5)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_5 and arg_215_1.time_ < 0 + var_218_5 + arg_218_0 and not isNil(var_218_4) and arg_215_1.var_.characterEffect1284ui_story then
				arg_215_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_215_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action3_2")
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_218_6 = 0
			local var_218_7 = 1.175

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_6 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_8 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(939012052).content)

				arg_215_1.text_.text = var_218_8

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_10 = 47 <= 0 and var_218_7 or var_218_7 * (utf8.len(var_218_8) / 47)

				if (47 <= 0 and var_218_7 or var_218_7 * (utf8.len(var_218_8) / 47)) > 0 and var_218_7 < var_218_10 then
					arg_215_1.talkMaxDuration = var_218_10

					if var_218_10 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_6
					end
				end

				arg_215_1.text_.text = var_218_8
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_11 = math.max(var_218_7, arg_215_1.talkMaxDuration)

			if var_218_6 <= arg_215_1.time_ and arg_215_1.time_ < var_218_6 + var_218_11 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_6) / var_218_11

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_6 + var_218_11 and arg_215_1.time_ < var_218_6 + var_218_11 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play939012053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 939012053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play939012054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1012ui_story = arg_219_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1012ui_story, Vector3.New(0.7, -1.05, -6.24), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1012ui_story"].transform.position).z)
				arg_219_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1012ui_story"].transform.localEulerAngles = arg_219_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -6.24)
				arg_219_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["1012ui_story"].transform.position).z)
				arg_219_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["1012ui_story"].transform.localEulerAngles = arg_219_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_222_1 = arg_219_1.actors_["1284ui_story"].transform

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1284ui_story = var_222_1.localPosition
			end

			local var_222_2 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 then
				var_222_1.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_219_1.time_ - 0) / var_222_2)
				var_222_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_1.position).x, (manager.ui.mainCamera.transform.position - var_222_1.position).y, (manager.ui.mainCamera.transform.position - var_222_1.position).z)
				var_222_1.localEulerAngles.z = 0
				var_222_1.localEulerAngles.x = 0
				var_222_1.localEulerAngles = var_222_1.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 then
				var_222_1.localPosition = Vector3.New(0, 100, 0)
				var_222_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_222_1.position).x, (manager.ui.mainCamera.transform.position - var_222_1.position).y, (manager.ui.mainCamera.transform.position - var_222_1.position).z)
				var_222_1.localEulerAngles.z = 0
				var_222_1.localEulerAngles.x = 0
				var_222_1.localEulerAngles = var_222_1.localEulerAngles
			end

			local var_222_3 = arg_219_1.actors_["1012ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_3) and arg_219_1.var_.characterEffect1012ui_story == nil then
				arg_219_1.var_.characterEffect1012ui_story = var_222_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_4 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_4 and not isNil(var_222_3) then
				if arg_219_1.var_.characterEffect1012ui_story and not isNil(var_222_3) then
					arg_219_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_4 and arg_219_1.time_ < 0 + var_222_4 + arg_222_0 and not isNil(var_222_3) and arg_219_1.var_.characterEffect1012ui_story then
				arg_219_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_222_6 = arg_219_1.actors_["1034ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_6) and arg_219_1.var_.characterEffect1034ui_story == nil then
				arg_219_1.var_.characterEffect1034ui_story = var_222_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_7 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_7 and not isNil(var_222_6) then
				if arg_219_1.var_.characterEffect1034ui_story and not isNil(var_222_6) then
					arg_219_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_7)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_7 and arg_219_1.time_ < 0 + var_222_7 + arg_222_0 and not isNil(var_222_6) and arg_219_1.var_.characterEffect1034ui_story then
				arg_219_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012actionlink/1012action424")
			end

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_222_8 = 0
			local var_222_9 = 0.275

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_8 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_10 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(939012053).content)

				arg_219_1.text_.text = var_222_10

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_12 = 11 <= 0 and var_222_9 or var_222_9 * (utf8.len(var_222_10) / 11)

				if (11 <= 0 and var_222_9 or var_222_9 * (utf8.len(var_222_10) / 11)) > 0 and var_222_9 < var_222_12 then
					arg_219_1.talkMaxDuration = var_222_12

					if var_222_12 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_12 + var_222_8
					end
				end

				arg_219_1.text_.text = var_222_10
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_13 = math.max(var_222_9, arg_219_1.talkMaxDuration)

			if var_222_8 <= arg_219_1.time_ and arg_219_1.time_ < var_222_8 + var_222_13 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_8) / var_222_13

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_8 + var_222_13 and arg_219_1.time_ < var_222_8 + var_222_13 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
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
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play939012054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 939012054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play939012055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["1012ui_story"]) and arg_223_1.var_.characterEffect1012ui_story == nil then
				arg_223_1.var_.characterEffect1012ui_story = arg_223_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["1012ui_story"]) then
				if arg_223_1.var_.characterEffect1012ui_story and not isNil(arg_223_1.actors_["1012ui_story"]) then
					arg_223_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_0)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["1012ui_story"]) and arg_223_1.var_.characterEffect1012ui_story then
				arg_223_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_226_1 = 0
			local var_226_2 = 0.85

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_3 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(939012054).content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 34 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 34)

				if (34 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 34)) > 0 and var_226_2 < var_226_5 then
					arg_223_1.talkMaxDuration = var_226_5

					if var_226_5 + var_226_1 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + var_226_1
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_6 = math.max(var_226_2, arg_223_1.talkMaxDuration)

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_6 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_1) / var_226_6

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_1 + var_226_6 and arg_223_1.time_ < var_226_1 + var_226_6 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play939012055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 939012055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play939012056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos6148ui_story = arg_227_1.actors_["6148ui_story"].transform.localPosition

				local var_230_0 = GameObjectTools.GetOrAddComponent(arg_227_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_230_0 then
					var_230_0:EnableDynamicBone(false)
				end
			end

			local var_230_1 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_1 then
				arg_227_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_227_1.time_ - 0) / var_230_1)
				arg_227_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["6148ui_story"].transform.position).z)
				arg_227_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["6148ui_story"].transform.localEulerAngles = arg_227_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_1 and arg_227_1.time_ < 0 + var_230_1 + arg_230_0 then
				arg_227_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_227_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["6148ui_story"].transform.position).z)
				arg_227_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["6148ui_story"].transform.localEulerAngles = arg_227_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_230_2 = GameObjectTools.GetOrAddComponent(arg_227_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_230_2 then
					var_230_2:EnableDynamicBone(true)
				end
			end

			local var_230_3 = arg_227_1.actors_["1034ui_story"].transform

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1034ui_story = var_230_3.localPosition
			end

			local var_230_4 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_4 then
				var_230_3.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_227_1.time_ - 0) / var_230_4)
				var_230_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_3.position).x, (manager.ui.mainCamera.transform.position - var_230_3.position).y, (manager.ui.mainCamera.transform.position - var_230_3.position).z)
				var_230_3.localEulerAngles.z = 0
				var_230_3.localEulerAngles.x = 0
				var_230_3.localEulerAngles = var_230_3.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_4 and arg_227_1.time_ < 0 + var_230_4 + arg_230_0 then
				var_230_3.localPosition = Vector3.New(0, 100, 0)
				var_230_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_3.position).x, (manager.ui.mainCamera.transform.position - var_230_3.position).y, (manager.ui.mainCamera.transform.position - var_230_3.position).z)
				var_230_3.localEulerAngles.z = 0
				var_230_3.localEulerAngles.x = 0
				var_230_3.localEulerAngles = var_230_3.localEulerAngles
			end

			local var_230_5 = arg_227_1.actors_["6148ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_5) and arg_227_1.var_.characterEffect6148ui_story == nil then
				arg_227_1.var_.characterEffect6148ui_story = var_230_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_6 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_6 and not isNil(var_230_5) then
				if arg_227_1.var_.characterEffect6148ui_story and not isNil(var_230_5) then
					arg_227_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_6 and arg_227_1.time_ < 0 + var_230_6 + arg_230_0 and not isNil(var_230_5) and arg_227_1.var_.characterEffect6148ui_story then
				arg_227_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_230_8 = 0
			local var_230_9 = 0.9

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_10 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(939012055).content)

				arg_227_1.text_.text = var_230_10

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_12 = 36 <= 0 and var_230_9 or var_230_9 * (utf8.len(var_230_10) / 36)

				if (36 <= 0 and var_230_9 or var_230_9 * (utf8.len(var_230_10) / 36)) > 0 and var_230_9 < var_230_12 then
					arg_227_1.talkMaxDuration = var_230_12

					if var_230_12 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_12 + var_230_8
					end
				end

				arg_227_1.text_.text = var_230_10
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_13 = math.max(var_230_9, arg_227_1.talkMaxDuration)

			if var_230_8 <= arg_227_1.time_ and arg_227_1.time_ < var_230_8 + var_230_13 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_8) / var_230_13

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_8 + var_230_13 and arg_227_1.time_ < var_230_8 + var_230_13 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
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
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play939012056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 939012056
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play939012057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1012ui_story = arg_231_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1012ui_story, Vector3.New(0.7, -1.05, -6.24), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1012ui_story"].transform.position).z)
				arg_231_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1012ui_story"].transform.localEulerAngles = arg_231_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -6.24)
				arg_231_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["1012ui_story"].transform.position).z)
				arg_231_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["1012ui_story"].transform.localEulerAngles = arg_231_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["1012ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1012ui_story == nil then
				arg_231_1.var_.characterEffect1012ui_story = var_234_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 and not isNil(var_234_1) then
				if arg_231_1.var_.characterEffect1012ui_story and not isNil(var_234_1) then
					arg_231_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect1012ui_story then
				arg_231_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_234_4 = arg_231_1.actors_["6148ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_4) and arg_231_1.var_.characterEffect6148ui_story == nil then
				arg_231_1.var_.characterEffect6148ui_story = var_234_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_5 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_5 and not isNil(var_234_4) then
				if arg_231_1.var_.characterEffect6148ui_story and not isNil(var_234_4) then
					arg_231_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_231_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_5)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_5 and arg_231_1.time_ < 0 + var_234_5 + arg_234_0 and not isNil(var_234_4) and arg_231_1.var_.characterEffect6148ui_story then
				arg_231_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_231_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action4_2")
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_234_6 = 0
			local var_234_7 = 0.55

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_6 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_8 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(939012056).content)

				arg_231_1.text_.text = var_234_8

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_10 = 22 <= 0 and var_234_7 or var_234_7 * (utf8.len(var_234_8) / 22)

				if (22 <= 0 and var_234_7 or var_234_7 * (utf8.len(var_234_8) / 22)) > 0 and var_234_7 < var_234_10 then
					arg_231_1.talkMaxDuration = var_234_10

					if var_234_10 + var_234_6 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_6
					end
				end

				arg_231_1.text_.text = var_234_8
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_11 = math.max(var_234_7, arg_231_1.talkMaxDuration)

			if var_234_6 <= arg_231_1.time_ and arg_231_1.time_ < var_234_6 + var_234_11 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_6) / var_234_11

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_6 + var_234_11 and arg_231_1.time_ < var_234_6 + var_234_11 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play939012057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 939012057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play939012058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos1034ui_story = arg_235_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_238_0 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 then
				arg_235_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1034ui_story, Vector3.New(-0.7, -0.93, -6), (arg_235_1.time_ - 0) / var_238_0)
				arg_235_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1034ui_story"].transform.position).z)
				arg_235_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1034ui_story"].transform.localEulerAngles = arg_235_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 then
				arg_235_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(-0.7, -0.93, -6)
				arg_235_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["1034ui_story"].transform.position).z)
				arg_235_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["1034ui_story"].transform.localEulerAngles = arg_235_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_238_1 = arg_235_1.actors_["6148ui_story"].transform

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos6148ui_story = var_238_1.localPosition

				local var_238_2 = GameObjectTools.GetOrAddComponent(var_238_1.gameObject, typeof(DynamicBoneHelper))

				if var_238_2 then
					var_238_2:EnableDynamicBone(false)
				end
			end

			local var_238_3 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_3 then
				var_238_1.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_235_1.time_ - 0) / var_238_3)
				var_238_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_1.position).x, (manager.ui.mainCamera.transform.position - var_238_1.position).y, (manager.ui.mainCamera.transform.position - var_238_1.position).z)
				var_238_1.localEulerAngles.z = 0
				var_238_1.localEulerAngles.x = 0
				var_238_1.localEulerAngles = var_238_1.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_3 and arg_235_1.time_ < 0 + var_238_3 + arg_238_0 then
				var_238_1.localPosition = Vector3.New(0, 100, 0)
				var_238_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_1.position).x, (manager.ui.mainCamera.transform.position - var_238_1.position).y, (manager.ui.mainCamera.transform.position - var_238_1.position).z)
				var_238_1.localEulerAngles.z = 0
				var_238_1.localEulerAngles.x = 0
				var_238_1.localEulerAngles = var_238_1.localEulerAngles

				local var_238_4 = GameObjectTools.GetOrAddComponent(var_238_1.gameObject, typeof(DynamicBoneHelper))

				if var_238_4 then
					var_238_4:EnableDynamicBone(true)
				end
			end

			local var_238_5 = arg_235_1.actors_["1034ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_5) and arg_235_1.var_.characterEffect1034ui_story == nil then
				arg_235_1.var_.characterEffect1034ui_story = var_238_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_6 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_6 and not isNil(var_238_5) then
				if arg_235_1.var_.characterEffect1034ui_story and not isNil(var_238_5) then
					arg_235_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_6 and arg_235_1.time_ < 0 + var_238_6 + arg_238_0 and not isNil(var_238_5) and arg_235_1.var_.characterEffect1034ui_story then
				arg_235_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_238_8 = arg_235_1.actors_["1012ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_8) and arg_235_1.var_.characterEffect1012ui_story == nil then
				arg_235_1.var_.characterEffect1012ui_story = var_238_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_9 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_9 and not isNil(var_238_8) then
				if arg_235_1.var_.characterEffect1012ui_story and not isNil(var_238_8) then
					arg_235_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_9)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_9 and arg_235_1.time_ < 0 + var_238_9 + arg_238_0 and not isNil(var_238_8) and arg_235_1.var_.characterEffect1012ui_story then
				arg_235_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_238_10 = 0
			local var_238_11 = 0.85

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_10 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_12 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(939012057).content)

				arg_235_1.text_.text = var_238_12

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_14 = 34 <= 0 and var_238_11 or var_238_11 * (utf8.len(var_238_12) / 34)

				if (34 <= 0 and var_238_11 or var_238_11 * (utf8.len(var_238_12) / 34)) > 0 and var_238_11 < var_238_14 then
					arg_235_1.talkMaxDuration = var_238_14

					if var_238_14 + var_238_10 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_14 + var_238_10
					end
				end

				arg_235_1.text_.text = var_238_12
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_15 = math.max(var_238_11, arg_235_1.talkMaxDuration)

			if var_238_10 <= arg_235_1.time_ and arg_235_1.time_ < var_238_10 + var_238_15 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_10) / var_238_15

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_10 + var_238_15 and arg_235_1.time_ < var_238_10 + var_238_15 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
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

		arg_235_1:InitPlayNodeList()
	end,
	Play939012058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 939012058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play939012059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1034ui_story = arg_239_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_242_0 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 then
				arg_239_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1034ui_story, Vector3.New(-0.7, -0.93, -6), (arg_239_1.time_ - 0) / var_242_0)
				arg_239_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1034ui_story"].transform.position).z)
				arg_239_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1034ui_story"].transform.localEulerAngles = arg_239_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 then
				arg_239_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(-0.7, -0.93, -6)
				arg_239_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1034ui_story"].transform.position).z)
				arg_239_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1034ui_story"].transform.localEulerAngles = arg_239_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_1")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanR", "EmotionTimelineAnimator")
			end

			local var_242_1 = 0
			local var_242_2 = 0.225

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_3 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(939012058).content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 9 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_3) / 9)

				if (9 <= 0 and var_242_2 or var_242_2 * (utf8.len(var_242_3) / 9)) > 0 and var_242_2 < var_242_5 then
					arg_239_1.talkMaxDuration = var_242_5

					if var_242_5 + var_242_1 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + var_242_1
					end
				end

				arg_239_1.text_.text = var_242_3
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_6 = math.max(var_242_2, arg_239_1.talkMaxDuration)

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_6 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_1) / var_242_6

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_1 + var_242_6 and arg_239_1.time_ < var_242_1 + var_242_6 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_239_1:InitPlayNodeList()
	end,
	Play939012059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 939012059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play939012060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1012ui_story = arg_243_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1012ui_story, Vector3.New(0.7, -1.05, -6.24), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1012ui_story"].transform.position).z)
				arg_243_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1012ui_story"].transform.localEulerAngles = arg_243_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -6.24)
				arg_243_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["1012ui_story"].transform.position).z)
				arg_243_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["1012ui_story"].transform.localEulerAngles = arg_243_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_246_1 = arg_243_1.actors_["1012ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1012ui_story == nil then
				arg_243_1.var_.characterEffect1012ui_story = var_246_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_2 and not isNil(var_246_1) then
				if arg_243_1.var_.characterEffect1012ui_story and not isNil(var_246_1) then
					arg_243_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_2 and arg_243_1.time_ < 0 + var_246_2 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect1012ui_story then
				arg_243_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_246_4 = arg_243_1.actors_["1034ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_4) and arg_243_1.var_.characterEffect1034ui_story == nil then
				arg_243_1.var_.characterEffect1034ui_story = var_246_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_5 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_5 and not isNil(var_246_4) then
				if arg_243_1.var_.characterEffect1034ui_story and not isNil(var_246_4) then
					arg_243_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_5)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_5 and arg_243_1.time_ < 0 + var_246_5 + arg_246_0 and not isNil(var_246_4) and arg_243_1.var_.characterEffect1034ui_story then
				arg_243_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_246_6 = 0
			local var_246_7 = 0.35

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_6 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_8 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(939012059).content)

				arg_243_1.text_.text = var_246_8

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_10 = 14 <= 0 and var_246_7 or var_246_7 * (utf8.len(var_246_8) / 14)

				if (14 <= 0 and var_246_7 or var_246_7 * (utf8.len(var_246_8) / 14)) > 0 and var_246_7 < var_246_10 then
					arg_243_1.talkMaxDuration = var_246_10

					if var_246_10 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_6
					end
				end

				arg_243_1.text_.text = var_246_8
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_11 = math.max(var_246_7, arg_243_1.talkMaxDuration)

			if var_246_6 <= arg_243_1.time_ and arg_243_1.time_ < var_246_6 + var_246_11 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_6) / var_246_11

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_6 + var_246_11 and arg_243_1.time_ < var_246_6 + var_246_11 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play939012060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 939012060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play939012061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos1034ui_story = arg_247_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_250_0 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 then
				arg_247_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1034ui_story, Vector3.New(-0.7, -0.93, -6), (arg_247_1.time_ - 0) / var_250_0)
				arg_247_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1034ui_story"].transform.position).z)
				arg_247_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1034ui_story"].transform.localEulerAngles = arg_247_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 then
				arg_247_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(-0.7, -0.93, -6)
				arg_247_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["1034ui_story"].transform.position).z)
				arg_247_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["1034ui_story"].transform.localEulerAngles = arg_247_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_250_1 = arg_247_1.actors_["1034ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1034ui_story == nil then
				arg_247_1.var_.characterEffect1034ui_story = var_250_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_2 and not isNil(var_250_1) then
				if arg_247_1.var_.characterEffect1034ui_story and not isNil(var_250_1) then
					arg_247_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_2 and arg_247_1.time_ < 0 + var_250_2 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect1034ui_story then
				arg_247_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_250_4 = arg_247_1.actors_["1012ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect1012ui_story == nil then
				arg_247_1.var_.characterEffect1012ui_story = var_250_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_5 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_5 and not isNil(var_250_4) then
				if arg_247_1.var_.characterEffect1012ui_story and not isNil(var_250_4) then
					arg_247_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_5)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_5 and arg_247_1.time_ < 0 + var_250_5 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect1012ui_story then
				arg_247_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_2")
			end

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_250_6 = 0
			local var_250_7 = 1.525

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_6 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_8 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(939012060).content)

				arg_247_1.text_.text = var_250_8

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_10 = 61 <= 0 and var_250_7 or var_250_7 * (utf8.len(var_250_8) / 61)

				if (61 <= 0 and var_250_7 or var_250_7 * (utf8.len(var_250_8) / 61)) > 0 and var_250_7 < var_250_10 then
					arg_247_1.talkMaxDuration = var_250_10

					if var_250_10 + var_250_6 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_6
					end
				end

				arg_247_1.text_.text = var_250_8
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_11 = math.max(var_250_7, arg_247_1.talkMaxDuration)

			if var_250_6 <= arg_247_1.time_ and arg_247_1.time_ < var_250_6 + var_250_11 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_6) / var_250_11

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_6 + var_250_11 and arg_247_1.time_ < var_250_6 + var_250_11 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play939012061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 939012061
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play939012062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1012ui_story = arg_251_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_254_0 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				arg_251_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1012ui_story, Vector3.New(0.7, -1.05, -6.24), (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1012ui_story"].transform.position).z)
				arg_251_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1012ui_story"].transform.localEulerAngles = arg_251_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				arg_251_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(0.7, -1.05, -6.24)
				arg_251_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["1012ui_story"].transform.position).z)
				arg_251_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["1012ui_story"].transform.localEulerAngles = arg_251_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_254_1 = arg_251_1.actors_["1012ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1012ui_story == nil then
				arg_251_1.var_.characterEffect1012ui_story = var_254_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_2 and not isNil(var_254_1) then
				if arg_251_1.var_.characterEffect1012ui_story and not isNil(var_254_1) then
					arg_251_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_2 and arg_251_1.time_ < 0 + var_254_2 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect1012ui_story then
				arg_251_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_254_4 = arg_251_1.actors_["1034ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_4) and arg_251_1.var_.characterEffect1034ui_story == nil then
				arg_251_1.var_.characterEffect1034ui_story = var_254_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_5 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_5 and not isNil(var_254_4) then
				if arg_251_1.var_.characterEffect1034ui_story and not isNil(var_254_4) then
					arg_251_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_5)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_5 and arg_251_1.time_ < 0 + var_254_5 + arg_254_0 and not isNil(var_254_4) and arg_251_1.var_.characterEffect1034ui_story then
				arg_251_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action2_1")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_254_6 = 0
			local var_254_7 = 0.2

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_6 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_8 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(939012061).content)

				arg_251_1.text_.text = var_254_8

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_10 = 8 <= 0 and var_254_7 or var_254_7 * (utf8.len(var_254_8) / 8)

				if (8 <= 0 and var_254_7 or var_254_7 * (utf8.len(var_254_8) / 8)) > 0 and var_254_7 < var_254_10 then
					arg_251_1.talkMaxDuration = var_254_10

					if var_254_10 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_10 + var_254_6
					end
				end

				arg_251_1.text_.text = var_254_8
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_11 = math.max(var_254_7, arg_251_1.talkMaxDuration)

			if var_254_6 <= arg_251_1.time_ and arg_251_1.time_ < var_254_6 + var_254_11 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_6) / var_254_11

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_6 + var_254_11 and arg_251_1.time_ < var_254_6 + var_254_11 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play939012062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 939012062
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play939012063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1034ui_story = arg_255_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_258_0 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 then
				arg_255_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1034ui_story, Vector3.New(-0.7, -0.93, -6), (arg_255_1.time_ - 0) / var_258_0)
				arg_255_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1034ui_story"].transform.position).z)
				arg_255_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["1034ui_story"].transform.localEulerAngles = arg_255_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 then
				arg_255_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(-0.7, -0.93, -6)
				arg_255_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["1034ui_story"].transform.position).z)
				arg_255_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["1034ui_story"].transform.localEulerAngles = arg_255_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_258_1 = arg_255_1.actors_["1034ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect1034ui_story == nil then
				arg_255_1.var_.characterEffect1034ui_story = var_258_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_2 and not isNil(var_258_1) then
				if arg_255_1.var_.characterEffect1034ui_story and not isNil(var_258_1) then
					arg_255_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_2 and arg_255_1.time_ < 0 + var_258_2 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect1034ui_story then
				arg_255_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_258_4 = arg_255_1.actors_["1012ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_4) and arg_255_1.var_.characterEffect1012ui_story == nil then
				arg_255_1.var_.characterEffect1012ui_story = var_258_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_5 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_5 and not isNil(var_258_4) then
				if arg_255_1.var_.characterEffect1012ui_story and not isNil(var_258_4) then
					arg_255_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_5)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_5 and arg_255_1.time_ < 0 + var_258_5 + arg_258_0 and not isNil(var_258_4) and arg_255_1.var_.characterEffect1012ui_story then
				arg_255_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_1")
			end

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_258_6 = 0
			local var_258_7 = 0.975

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_6 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_8 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(939012062).content)

				arg_255_1.text_.text = var_258_8

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_10 = 39 <= 0 and var_258_7 or var_258_7 * (utf8.len(var_258_8) / 39)

				if (39 <= 0 and var_258_7 or var_258_7 * (utf8.len(var_258_8) / 39)) > 0 and var_258_7 < var_258_10 then
					arg_255_1.talkMaxDuration = var_258_10

					if var_258_10 + var_258_6 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_10 + var_258_6
					end
				end

				arg_255_1.text_.text = var_258_8
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_11 = math.max(var_258_7, arg_255_1.talkMaxDuration)

			if var_258_6 <= arg_255_1.time_ and arg_255_1.time_ < var_258_6 + var_258_11 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_6) / var_258_11

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_6 + var_258_11 and arg_255_1.time_ < var_258_6 + var_258_11 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play939012063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 939012063
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play939012064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos6148ui_story = arg_259_1.actors_["6148ui_story"].transform.localPosition

				local var_262_0 = GameObjectTools.GetOrAddComponent(arg_259_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_262_0 then
					var_262_0:EnableDynamicBone(false)
				end
			end

			local var_262_1 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_1 then
				arg_259_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_259_1.time_ - 0) / var_262_1)
				arg_259_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["6148ui_story"].transform.position).z)
				arg_259_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["6148ui_story"].transform.localEulerAngles = arg_259_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_1 and arg_259_1.time_ < 0 + var_262_1 + arg_262_0 then
				arg_259_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_259_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_259_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_259_1.actors_["6148ui_story"].transform.position).z)
				arg_259_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_259_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_259_1.actors_["6148ui_story"].transform.localEulerAngles = arg_259_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_262_2 = GameObjectTools.GetOrAddComponent(arg_259_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_262_2 then
					var_262_2:EnableDynamicBone(true)
				end
			end

			local var_262_3 = arg_259_1.actors_["1012ui_story"].transform

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos1012ui_story = var_262_3.localPosition
			end

			local var_262_4 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				var_262_3.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1012ui_story, Vector3.New(0, 100, 0), (arg_259_1.time_ - 0) / var_262_4)
				var_262_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_262_3.position).x, (manager.ui.mainCamera.transform.position - var_262_3.position).y, (manager.ui.mainCamera.transform.position - var_262_3.position).z)
				var_262_3.localEulerAngles.z = 0
				var_262_3.localEulerAngles.x = 0
				var_262_3.localEulerAngles = var_262_3.localEulerAngles
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				var_262_3.localPosition = Vector3.New(0, 100, 0)
				var_262_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_262_3.position).x, (manager.ui.mainCamera.transform.position - var_262_3.position).y, (manager.ui.mainCamera.transform.position - var_262_3.position).z)
				var_262_3.localEulerAngles.z = 0
				var_262_3.localEulerAngles.x = 0
				var_262_3.localEulerAngles = var_262_3.localEulerAngles
			end

			local var_262_5 = arg_259_1.actors_["6148ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_5) and arg_259_1.var_.characterEffect6148ui_story == nil then
				arg_259_1.var_.characterEffect6148ui_story = var_262_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_6 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_6 and not isNil(var_262_5) then
				if arg_259_1.var_.characterEffect6148ui_story and not isNil(var_262_5) then
					arg_259_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= 0 + var_262_6 and arg_259_1.time_ < 0 + var_262_6 + arg_262_0 and not isNil(var_262_5) and arg_259_1.var_.characterEffect6148ui_story then
				arg_259_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_262_8 = arg_259_1.actors_["1034ui_story"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_8) and arg_259_1.var_.characterEffect1034ui_story == nil then
				arg_259_1.var_.characterEffect1034ui_story = var_262_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_9 = 0.200000002980232

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_9 and not isNil(var_262_8) then
				if arg_259_1.var_.characterEffect1034ui_story and not isNil(var_262_8) then
					arg_259_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_259_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_259_1.time_ - 0) / var_262_9)
				end
			end

			if arg_259_1.time_ >= 0 + var_262_9 and arg_259_1.time_ < 0 + var_262_9 + arg_262_0 and not isNil(var_262_8) and arg_259_1.var_.characterEffect1034ui_story then
				arg_259_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_259_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_262_10 = 0
			local var_262_11 = 0.125

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_10 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_12 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(939012063).content)

				arg_259_1.text_.text = var_262_12

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_14 = 5 <= 0 and var_262_11 or var_262_11 * (utf8.len(var_262_12) / 5)

				if (5 <= 0 and var_262_11 or var_262_11 * (utf8.len(var_262_12) / 5)) > 0 and var_262_11 < var_262_14 then
					arg_259_1.talkMaxDuration = var_262_14

					if var_262_14 + var_262_10 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_14 + var_262_10
					end
				end

				arg_259_1.text_.text = var_262_12
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_15 = math.max(var_262_11, arg_259_1.talkMaxDuration)

			if var_262_10 <= arg_259_1.time_ and arg_259_1.time_ < var_262_10 + var_262_15 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_10) / var_262_15

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_10 + var_262_15 and arg_259_1.time_ < var_262_10 + var_262_15 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
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
				actorName = "1012ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play939012064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 939012064
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play939012065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos1034ui_story = arg_263_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos1034ui_story, Vector3.New(-0.7, -0.93, -6), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1034ui_story"].transform.position).z)
				arg_263_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1034ui_story"].transform.localEulerAngles = arg_263_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(-0.7, -0.93, -6)
				arg_263_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["1034ui_story"].transform.position).z)
				arg_263_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["1034ui_story"].transform.localEulerAngles = arg_263_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["1034ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1034ui_story == nil then
				arg_263_1.var_.characterEffect1034ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect1034ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect1034ui_story then
				arg_263_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_266_4 = arg_263_1.actors_["6148ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_4) and arg_263_1.var_.characterEffect6148ui_story == nil then
				arg_263_1.var_.characterEffect6148ui_story = var_266_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_5 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_5 and not isNil(var_266_4) then
				if arg_263_1.var_.characterEffect6148ui_story and not isNil(var_266_4) then
					arg_263_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_263_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_5)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_5 and arg_263_1.time_ < 0 + var_266_5 + arg_266_0 and not isNil(var_266_4) and arg_263_1.var_.characterEffect6148ui_story then
				arg_263_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_263_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_2")
			end

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_266_6 = 0
			local var_266_7 = 0.425

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_6 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_8 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(939012064).content)

				arg_263_1.text_.text = var_266_8

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_10 = 17 <= 0 and var_266_7 or var_266_7 * (utf8.len(var_266_8) / 17)

				if (17 <= 0 and var_266_7 or var_266_7 * (utf8.len(var_266_8) / 17)) > 0 and var_266_7 < var_266_10 then
					arg_263_1.talkMaxDuration = var_266_10

					if var_266_10 + var_266_6 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_10 + var_266_6
					end
				end

				arg_263_1.text_.text = var_266_8
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_11 = math.max(var_266_7, arg_263_1.talkMaxDuration)

			if var_266_6 <= arg_263_1.time_ and arg_263_1.time_ < var_266_6 + var_266_11 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_6) / var_266_11

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_6 + var_266_11 and arg_263_1.time_ < var_266_6 + var_266_11 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play939012065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 939012065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play939012066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["1034ui_story"]) and arg_267_1.var_.characterEffect1034ui_story == nil then
				arg_267_1.var_.characterEffect1034ui_story = arg_267_1.actors_["1034ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_0 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["1034ui_story"]) then
				if arg_267_1.var_.characterEffect1034ui_story and not isNil(arg_267_1.actors_["1034ui_story"]) then
					arg_267_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_0)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["1034ui_story"]) and arg_267_1.var_.characterEffect1034ui_story then
				arg_267_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			local var_270_1 = 0
			local var_270_2 = 0.575

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_3 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(939012065).content)

				arg_267_1.text_.text = var_270_3

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_5 = 23 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 23)

				if (23 <= 0 and var_270_2 or var_270_2 * (utf8.len(var_270_3) / 23)) > 0 and var_270_2 < var_270_5 then
					arg_267_1.talkMaxDuration = var_270_5

					if var_270_5 + var_270_1 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + var_270_1
					end
				end

				arg_267_1.text_.text = var_270_3
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_6 = math.max(var_270_2, arg_267_1.talkMaxDuration)

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_6 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_1) / var_270_6

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_1 + var_270_6 and arg_267_1.time_ < var_270_1 + var_270_6 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play939012066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 939012066
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play939012067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos6148ui_story = arg_271_1.actors_["6148ui_story"].transform.localPosition

				local var_274_0 = GameObjectTools.GetOrAddComponent(arg_271_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_274_0 then
					var_274_0:EnableDynamicBone(false)
				end
			end

			local var_274_1 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_1 then
				arg_271_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_271_1.time_ - 0) / var_274_1)
				arg_271_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["6148ui_story"].transform.position).z)
				arg_271_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["6148ui_story"].transform.localEulerAngles = arg_271_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_1 and arg_271_1.time_ < 0 + var_274_1 + arg_274_0 then
				arg_271_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_271_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["6148ui_story"].transform.position).z)
				arg_271_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["6148ui_story"].transform.localEulerAngles = arg_271_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_274_2 = GameObjectTools.GetOrAddComponent(arg_271_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_274_2 then
					var_274_2:EnableDynamicBone(true)
				end
			end

			local var_274_3 = arg_271_1.actors_["6148ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_3) and arg_271_1.var_.characterEffect6148ui_story == nil then
				arg_271_1.var_.characterEffect6148ui_story = var_274_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_4 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 and not isNil(var_274_3) then
				if arg_271_1.var_.characterEffect6148ui_story and not isNil(var_274_3) then
					arg_271_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 and not isNil(var_274_3) and arg_271_1.var_.characterEffect6148ui_story then
				arg_271_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_274_6 = 0
			local var_274_7 = 1.075

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_6 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_8 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(939012066).content)

				arg_271_1.text_.text = var_274_8

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_10 = 43 <= 0 and var_274_7 or var_274_7 * (utf8.len(var_274_8) / 43)

				if (43 <= 0 and var_274_7 or var_274_7 * (utf8.len(var_274_8) / 43)) > 0 and var_274_7 < var_274_10 then
					arg_271_1.talkMaxDuration = var_274_10

					if var_274_10 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_6
					end
				end

				arg_271_1.text_.text = var_274_8
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_11 = math.max(var_274_7, arg_271_1.talkMaxDuration)

			if var_274_6 <= arg_271_1.time_ and arg_271_1.time_ < var_274_6 + var_274_11 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_6) / var_274_11

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_6 + var_274_11 and arg_271_1.time_ < var_274_6 + var_274_11 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
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

		arg_271_1:InitPlayNodeList()
	end,
	Play939012067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 939012067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play939012068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos1034ui_story = arg_275_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos1034ui_story, Vector3.New(-0.7, -0.93, -6), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1034ui_story"].transform.position).z)
				arg_275_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1034ui_story"].transform.localEulerAngles = arg_275_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(-0.7, -0.93, -6)
				arg_275_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["1034ui_story"].transform.position).z)
				arg_275_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["1034ui_story"].transform.localEulerAngles = arg_275_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_278_1 = arg_275_1.actors_["1034ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1034ui_story == nil then
				arg_275_1.var_.characterEffect1034ui_story = var_278_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_2 and not isNil(var_278_1) then
				if arg_275_1.var_.characterEffect1034ui_story and not isNil(var_278_1) then
					arg_275_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_2 and arg_275_1.time_ < 0 + var_278_2 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect1034ui_story then
				arg_275_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_278_4 = arg_275_1.actors_["6148ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_4) and arg_275_1.var_.characterEffect6148ui_story == nil then
				arg_275_1.var_.characterEffect6148ui_story = var_278_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_5 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_5 and not isNil(var_278_4) then
				if arg_275_1.var_.characterEffect6148ui_story and not isNil(var_278_4) then
					arg_275_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_275_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_5)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_5 and arg_275_1.time_ < 0 + var_278_5 + arg_278_0 and not isNil(var_278_4) and arg_275_1.var_.characterEffect6148ui_story then
				arg_275_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_275_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_278_6 = 0
			local var_278_7 = 0.55

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_6 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_8 = arg_275_1:FormatText(arg_275_1:GetWordFromCfg(939012067).content)

				arg_275_1.text_.text = var_278_8

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_10 = 22 <= 0 and var_278_7 or var_278_7 * (utf8.len(var_278_8) / 22)

				if (22 <= 0 and var_278_7 or var_278_7 * (utf8.len(var_278_8) / 22)) > 0 and var_278_7 < var_278_10 then
					arg_275_1.talkMaxDuration = var_278_10

					if var_278_10 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_10 + var_278_6
					end
				end

				arg_275_1.text_.text = var_278_8
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_11 = math.max(var_278_7, arg_275_1.talkMaxDuration)

			if var_278_6 <= arg_275_1.time_ and arg_275_1.time_ < var_278_6 + var_278_11 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_6) / var_278_11

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_6 + var_278_11 and arg_275_1.time_ < var_278_6 + var_278_11 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play939012068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 939012068
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play939012069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos6148ui_story = arg_279_1.actors_["6148ui_story"].transform.localPosition

				local var_282_0 = GameObjectTools.GetOrAddComponent(arg_279_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_282_0 then
					var_282_0:EnableDynamicBone(false)
				end
			end

			local var_282_1 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_1 then
				arg_279_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_279_1.time_ - 0) / var_282_1)
				arg_279_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["6148ui_story"].transform.position).z)
				arg_279_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["6148ui_story"].transform.localEulerAngles = arg_279_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_279_1.time_ >= 0 + var_282_1 and arg_279_1.time_ < 0 + var_282_1 + arg_282_0 then
				arg_279_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_279_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_279_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_279_1.actors_["6148ui_story"].transform.position).z)
				arg_279_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_279_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_279_1.actors_["6148ui_story"].transform.localEulerAngles = arg_279_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_282_2 = GameObjectTools.GetOrAddComponent(arg_279_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_282_2 then
					var_282_2:EnableDynamicBone(true)
				end
			end

			local var_282_3 = arg_279_1.actors_["6148ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_3) and arg_279_1.var_.characterEffect6148ui_story == nil then
				arg_279_1.var_.characterEffect6148ui_story = var_282_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_4 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 and not isNil(var_282_3) then
				if arg_279_1.var_.characterEffect6148ui_story and not isNil(var_282_3) then
					arg_279_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 and not isNil(var_282_3) and arg_279_1.var_.characterEffect6148ui_story then
				arg_279_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_282_6 = arg_279_1.actors_["1034ui_story"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_6) and arg_279_1.var_.characterEffect1034ui_story == nil then
				arg_279_1.var_.characterEffect1034ui_story = var_282_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_7 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_7 and not isNil(var_282_6) then
				if arg_279_1.var_.characterEffect1034ui_story and not isNil(var_282_6) then
					arg_279_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_7)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_7 and arg_279_1.time_ < 0 + var_282_7 + arg_282_0 and not isNil(var_282_6) and arg_279_1.var_.characterEffect1034ui_story then
				arg_279_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_282_8 = 0
			local var_282_9 = 1.15

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_8 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_10 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(939012068).content)

				arg_279_1.text_.text = var_282_10

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_12 = 46 <= 0 and var_282_9 or var_282_9 * (utf8.len(var_282_10) / 46)

				if (46 <= 0 and var_282_9 or var_282_9 * (utf8.len(var_282_10) / 46)) > 0 and var_282_9 < var_282_12 then
					arg_279_1.talkMaxDuration = var_282_12

					if var_282_12 + var_282_8 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_12 + var_282_8
					end
				end

				arg_279_1.text_.text = var_282_10
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_13 = math.max(var_282_9, arg_279_1.talkMaxDuration)

			if var_282_8 <= arg_279_1.time_ and arg_279_1.time_ < var_282_8 + var_282_13 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_8) / var_282_13

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_8 + var_282_13 and arg_279_1.time_ < var_282_8 + var_282_13 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
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

		arg_279_1:InitPlayNodeList()
	end,
	Play939012069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 939012069
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play939012070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1054ui_story = arg_283_1.actors_["1054ui_story"].transform.localPosition

				local var_286_0 = GameObjectTools.GetOrAddComponent(arg_283_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_286_0 then
					var_286_0:EnableDynamicBone(false)
				end
			end

			local var_286_1 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_1 then
				arg_283_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_283_1.time_ - 0) / var_286_1)
				arg_283_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1054ui_story"].transform.position).z)
				arg_283_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1054ui_story"].transform.localEulerAngles = arg_283_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_1 and arg_283_1.time_ < 0 + var_286_1 + arg_286_0 then
				arg_283_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_283_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["1054ui_story"].transform.position).z)
				arg_283_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["1054ui_story"].transform.localEulerAngles = arg_283_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_286_2 = GameObjectTools.GetOrAddComponent(arg_283_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_286_2 then
					var_286_2:EnableDynamicBone(true)
				end
			end

			local var_286_3 = arg_283_1.actors_["1034ui_story"].transform

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos1034ui_story = var_286_3.localPosition
			end

			local var_286_4 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				var_286_3.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_283_1.time_ - 0) / var_286_4)
				var_286_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_3.position).x, (manager.ui.mainCamera.transform.position - var_286_3.position).y, (manager.ui.mainCamera.transform.position - var_286_3.position).z)
				var_286_3.localEulerAngles.z = 0
				var_286_3.localEulerAngles.x = 0
				var_286_3.localEulerAngles = var_286_3.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				var_286_3.localPosition = Vector3.New(0, 100, 0)
				var_286_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_3.position).x, (manager.ui.mainCamera.transform.position - var_286_3.position).y, (manager.ui.mainCamera.transform.position - var_286_3.position).z)
				var_286_3.localEulerAngles.z = 0
				var_286_3.localEulerAngles.x = 0
				var_286_3.localEulerAngles = var_286_3.localEulerAngles
			end

			local var_286_5 = arg_283_1.actors_["1054ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_5) and arg_283_1.var_.characterEffect1054ui_story == nil then
				arg_283_1.var_.characterEffect1054ui_story = var_286_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_6 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_6 and not isNil(var_286_5) then
				if arg_283_1.var_.characterEffect1054ui_story and not isNil(var_286_5) then
					arg_283_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_6 and arg_283_1.time_ < 0 + var_286_6 + arg_286_0 and not isNil(var_286_5) and arg_283_1.var_.characterEffect1054ui_story then
				arg_283_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_286_8 = arg_283_1.actors_["6148ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_8) and arg_283_1.var_.characterEffect6148ui_story == nil then
				arg_283_1.var_.characterEffect6148ui_story = var_286_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_9 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_9 and not isNil(var_286_8) then
				if arg_283_1.var_.characterEffect6148ui_story and not isNil(var_286_8) then
					arg_283_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_283_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_9)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_9 and arg_283_1.time_ < 0 + var_286_9 + arg_286_0 and not isNil(var_286_8) and arg_283_1.var_.characterEffect6148ui_story then
				arg_283_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_283_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_286_10 = 0
			local var_286_11 = 0.55

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_10 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_12 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(939012069).content)

				arg_283_1.text_.text = var_286_12

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_14 = 22 <= 0 and var_286_11 or var_286_11 * (utf8.len(var_286_12) / 22)

				if (22 <= 0 and var_286_11 or var_286_11 * (utf8.len(var_286_12) / 22)) > 0 and var_286_11 < var_286_14 then
					arg_283_1.talkMaxDuration = var_286_14

					if var_286_14 + var_286_10 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_14 + var_286_10
					end
				end

				arg_283_1.text_.text = var_286_12
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_15 = math.max(var_286_11, arg_283_1.talkMaxDuration)

			if var_286_10 <= arg_283_1.time_ and arg_283_1.time_ < var_286_10 + var_286_15 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_10) / var_286_15

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_10 + var_286_15 and arg_283_1.time_ < var_286_10 + var_286_15 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
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
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play939012070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 939012070
		arg_287_1.duration_ = 5

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play939012071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos6148ui_story = arg_287_1.actors_["6148ui_story"].transform.localPosition

				local var_290_0 = GameObjectTools.GetOrAddComponent(arg_287_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_290_0 then
					var_290_0:EnableDynamicBone(false)
				end
			end

			local var_290_1 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_1 then
				arg_287_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_287_1.time_ - 0) / var_290_1)
				arg_287_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["6148ui_story"].transform.position).z)
				arg_287_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["6148ui_story"].transform.localEulerAngles = arg_287_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_1 and arg_287_1.time_ < 0 + var_290_1 + arg_290_0 then
				arg_287_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_287_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["6148ui_story"].transform.position).z)
				arg_287_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["6148ui_story"].transform.localEulerAngles = arg_287_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_290_2 = GameObjectTools.GetOrAddComponent(arg_287_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_290_2 then
					var_290_2:EnableDynamicBone(true)
				end
			end

			local var_290_3 = arg_287_1.actors_["6148ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_3) and arg_287_1.var_.characterEffect6148ui_story == nil then
				arg_287_1.var_.characterEffect6148ui_story = var_290_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_4 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_4 and not isNil(var_290_3) then
				if arg_287_1.var_.characterEffect6148ui_story and not isNil(var_290_3) then
					arg_287_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_4 and arg_287_1.time_ < 0 + var_290_4 + arg_290_0 and not isNil(var_290_3) and arg_287_1.var_.characterEffect6148ui_story then
				arg_287_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_290_6 = arg_287_1.actors_["1054ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_6) and arg_287_1.var_.characterEffect1054ui_story == nil then
				arg_287_1.var_.characterEffect1054ui_story = var_290_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_7 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_7 and not isNil(var_290_6) then
				if arg_287_1.var_.characterEffect1054ui_story and not isNil(var_290_6) then
					arg_287_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_287_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_7)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_7 and arg_287_1.time_ < 0 + var_290_7 + arg_290_0 and not isNil(var_290_6) and arg_287_1.var_.characterEffect1054ui_story then
				arg_287_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_287_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_290_8 = 0
			local var_290_9 = 0.5

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_8 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_10 = arg_287_1:FormatText(arg_287_1:GetWordFromCfg(939012070).content)

				arg_287_1.text_.text = var_290_10

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_12 = 20 <= 0 and var_290_9 or var_290_9 * (utf8.len(var_290_10) / 20)

				if (20 <= 0 and var_290_9 or var_290_9 * (utf8.len(var_290_10) / 20)) > 0 and var_290_9 < var_290_12 then
					arg_287_1.talkMaxDuration = var_290_12

					if var_290_12 + var_290_8 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_12 + var_290_8
					end
				end

				arg_287_1.text_.text = var_290_10
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)
				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_13 = math.max(var_290_9, arg_287_1.talkMaxDuration)

			if var_290_8 <= arg_287_1.time_ and arg_287_1.time_ < var_290_8 + var_290_13 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_8) / var_290_13

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_8 + var_290_13 and arg_287_1.time_ < var_290_8 + var_290_13 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
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

		arg_287_1:InitPlayNodeList()
	end,
	Play939012071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 939012071
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play939012072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1034ui_story = arg_291_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_294_0 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 then
				arg_291_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1034ui_story, Vector3.New(0.7, -0.93, -6), (arg_291_1.time_ - 0) / var_294_0)
				arg_291_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1034ui_story"].transform.position).z)
				arg_291_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1034ui_story"].transform.localEulerAngles = arg_291_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 then
				arg_291_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(0.7, -0.93, -6)
				arg_291_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["1034ui_story"].transform.position).z)
				arg_291_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["1034ui_story"].transform.localEulerAngles = arg_291_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_294_1 = arg_291_1.actors_["6148ui_story"].transform

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos6148ui_story = var_294_1.localPosition

				local var_294_2 = GameObjectTools.GetOrAddComponent(var_294_1.gameObject, typeof(DynamicBoneHelper))

				if var_294_2 then
					var_294_2:EnableDynamicBone(false)
				end
			end

			local var_294_3 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_3 then
				var_294_1.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_291_1.time_ - 0) / var_294_3)
				var_294_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_1.position).x, (manager.ui.mainCamera.transform.position - var_294_1.position).y, (manager.ui.mainCamera.transform.position - var_294_1.position).z)
				var_294_1.localEulerAngles.z = 0
				var_294_1.localEulerAngles.x = 0
				var_294_1.localEulerAngles = var_294_1.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_3 and arg_291_1.time_ < 0 + var_294_3 + arg_294_0 then
				var_294_1.localPosition = Vector3.New(0, 100, 0)
				var_294_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_294_1.position).x, (manager.ui.mainCamera.transform.position - var_294_1.position).y, (manager.ui.mainCamera.transform.position - var_294_1.position).z)
				var_294_1.localEulerAngles.z = 0
				var_294_1.localEulerAngles.x = 0
				var_294_1.localEulerAngles = var_294_1.localEulerAngles

				local var_294_4 = GameObjectTools.GetOrAddComponent(var_294_1.gameObject, typeof(DynamicBoneHelper))

				if var_294_4 then
					var_294_4:EnableDynamicBone(true)
				end
			end

			local var_294_5 = arg_291_1.actors_["1034ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_5) and arg_291_1.var_.characterEffect1034ui_story == nil then
				arg_291_1.var_.characterEffect1034ui_story = var_294_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_6 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_6 and not isNil(var_294_5) then
				if arg_291_1.var_.characterEffect1034ui_story and not isNil(var_294_5) then
					arg_291_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_6 and arg_291_1.time_ < 0 + var_294_6 + arg_294_0 and not isNil(var_294_5) and arg_291_1.var_.characterEffect1034ui_story then
				arg_291_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_294_8 = arg_291_1.actors_["6148ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_8) and arg_291_1.var_.characterEffect6148ui_story == nil then
				arg_291_1.var_.characterEffect6148ui_story = var_294_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_9 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_9 and not isNil(var_294_8) then
				if arg_291_1.var_.characterEffect6148ui_story and not isNil(var_294_8) then
					arg_291_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_291_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_9)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_9 and arg_291_1.time_ < 0 + var_294_9 + arg_294_0 and not isNil(var_294_8) and arg_291_1.var_.characterEffect6148ui_story then
				arg_291_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_291_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_294_10 = 0
			local var_294_11 = 0.65

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_10 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_12 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(939012071).content)

				arg_291_1.text_.text = var_294_12

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_14 = 26 <= 0 and var_294_11 or var_294_11 * (utf8.len(var_294_12) / 26)

				if (26 <= 0 and var_294_11 or var_294_11 * (utf8.len(var_294_12) / 26)) > 0 and var_294_11 < var_294_14 then
					arg_291_1.talkMaxDuration = var_294_14

					if var_294_14 + var_294_10 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_14 + var_294_10
					end
				end

				arg_291_1.text_.text = var_294_12
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_15 = math.max(var_294_11, arg_291_1.talkMaxDuration)

			if var_294_10 <= arg_291_1.time_ and arg_291_1.time_ < var_294_10 + var_294_15 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_10) / var_294_15

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_10 + var_294_15 and arg_291_1.time_ < var_294_10 + var_294_15 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
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

		arg_291_1:InitPlayNodeList()
	end,
	Play939012072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 939012072
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play939012073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos1054ui_story = arg_295_1.actors_["1054ui_story"].transform.localPosition

				local var_298_0 = GameObjectTools.GetOrAddComponent(arg_295_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_298_0 then
					var_298_0:EnableDynamicBone(false)
				end
			end

			local var_298_1 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_1 then
				arg_295_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_295_1.time_ - 0) / var_298_1)
				arg_295_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1054ui_story"].transform.position).z)
				arg_295_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1054ui_story"].transform.localEulerAngles = arg_295_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_1 and arg_295_1.time_ < 0 + var_298_1 + arg_298_0 then
				arg_295_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_295_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["1054ui_story"].transform.position).z)
				arg_295_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["1054ui_story"].transform.localEulerAngles = arg_295_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_298_2 = GameObjectTools.GetOrAddComponent(arg_295_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_298_2 then
					var_298_2:EnableDynamicBone(true)
				end
			end

			local var_298_3 = arg_295_1.actors_["1054ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_3) and arg_295_1.var_.characterEffect1054ui_story == nil then
				arg_295_1.var_.characterEffect1054ui_story = var_298_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_4 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_4 and not isNil(var_298_3) then
				if arg_295_1.var_.characterEffect1054ui_story and not isNil(var_298_3) then
					arg_295_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= 0 + var_298_4 and arg_295_1.time_ < 0 + var_298_4 + arg_298_0 and not isNil(var_298_3) and arg_295_1.var_.characterEffect1054ui_story then
				arg_295_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_298_6 = arg_295_1.actors_["1034ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_6) and arg_295_1.var_.characterEffect1034ui_story == nil then
				arg_295_1.var_.characterEffect1034ui_story = var_298_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_7 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 and not isNil(var_298_6) then
				if arg_295_1.var_.characterEffect1034ui_story and not isNil(var_298_6) then
					arg_295_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_7)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 and not isNil(var_298_6) and arg_295_1.var_.characterEffect1034ui_story then
				arg_295_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_2")
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_298_8 = 0
			local var_298_9 = 0.75

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_8 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_10 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(939012072).content)

				arg_295_1.text_.text = var_298_10

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_12 = 30 <= 0 and var_298_9 or var_298_9 * (utf8.len(var_298_10) / 30)

				if (30 <= 0 and var_298_9 or var_298_9 * (utf8.len(var_298_10) / 30)) > 0 and var_298_9 < var_298_12 then
					arg_295_1.talkMaxDuration = var_298_12

					if var_298_12 + var_298_8 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_12 + var_298_8
					end
				end

				arg_295_1.text_.text = var_298_10
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_13 = math.max(var_298_9, arg_295_1.talkMaxDuration)

			if var_298_8 <= arg_295_1.time_ and arg_295_1.time_ < var_298_8 + var_298_13 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_8) / var_298_13

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_8 + var_298_13 and arg_295_1.time_ < var_298_8 + var_298_13 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
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

		arg_295_1:InitPlayNodeList()
	end,
	Play939012073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 939012073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play939012074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos6148ui_story = arg_299_1.actors_["6148ui_story"].transform.localPosition

				local var_302_0 = GameObjectTools.GetOrAddComponent(arg_299_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_302_0 then
					var_302_0:EnableDynamicBone(false)
				end
			end

			local var_302_1 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_1 then
				arg_299_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_299_1.time_ - 0) / var_302_1)
				arg_299_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["6148ui_story"].transform.position).z)
				arg_299_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["6148ui_story"].transform.localEulerAngles = arg_299_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_1 and arg_299_1.time_ < 0 + var_302_1 + arg_302_0 then
				arg_299_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_299_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["6148ui_story"].transform.position).z)
				arg_299_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["6148ui_story"].transform.localEulerAngles = arg_299_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_302_2 = GameObjectTools.GetOrAddComponent(arg_299_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_302_2 then
					var_302_2:EnableDynamicBone(true)
				end
			end

			local var_302_3 = arg_299_1.actors_["1034ui_story"].transform

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos1034ui_story = var_302_3.localPosition
			end

			local var_302_4 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_4 then
				var_302_3.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_299_1.time_ - 0) / var_302_4)
				var_302_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_3.position).x, (manager.ui.mainCamera.transform.position - var_302_3.position).y, (manager.ui.mainCamera.transform.position - var_302_3.position).z)
				var_302_3.localEulerAngles.z = 0
				var_302_3.localEulerAngles.x = 0
				var_302_3.localEulerAngles = var_302_3.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_4 and arg_299_1.time_ < 0 + var_302_4 + arg_302_0 then
				var_302_3.localPosition = Vector3.New(0, 100, 0)
				var_302_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_302_3.position).x, (manager.ui.mainCamera.transform.position - var_302_3.position).y, (manager.ui.mainCamera.transform.position - var_302_3.position).z)
				var_302_3.localEulerAngles.z = 0
				var_302_3.localEulerAngles.x = 0
				var_302_3.localEulerAngles = var_302_3.localEulerAngles
			end

			local var_302_5 = arg_299_1.actors_["6148ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_5) and arg_299_1.var_.characterEffect6148ui_story == nil then
				arg_299_1.var_.characterEffect6148ui_story = var_302_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_6 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_6 and not isNil(var_302_5) then
				if arg_299_1.var_.characterEffect6148ui_story and not isNil(var_302_5) then
					arg_299_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= 0 + var_302_6 and arg_299_1.time_ < 0 + var_302_6 + arg_302_0 and not isNil(var_302_5) and arg_299_1.var_.characterEffect6148ui_story then
				arg_299_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_302_8 = arg_299_1.actors_["1054ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_8) and arg_299_1.var_.characterEffect1054ui_story == nil then
				arg_299_1.var_.characterEffect1054ui_story = var_302_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_9 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_9 and not isNil(var_302_8) then
				if arg_299_1.var_.characterEffect1054ui_story and not isNil(var_302_8) then
					arg_299_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_299_1.time_ - 0) / var_302_9)
				end
			end

			if arg_299_1.time_ >= 0 + var_302_9 and arg_299_1.time_ < 0 + var_302_9 + arg_302_0 and not isNil(var_302_8) and arg_299_1.var_.characterEffect1054ui_story then
				arg_299_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_302_10 = 0
			local var_302_11 = 1.2

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_10 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_12 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(939012073).content)

				arg_299_1.text_.text = var_302_12

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_14 = 48 <= 0 and var_302_11 or var_302_11 * (utf8.len(var_302_12) / 48)

				if (48 <= 0 and var_302_11 or var_302_11 * (utf8.len(var_302_12) / 48)) > 0 and var_302_11 < var_302_14 then
					arg_299_1.talkMaxDuration = var_302_14

					if var_302_14 + var_302_10 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_14 + var_302_10
					end
				end

				arg_299_1.text_.text = var_302_12
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_15 = math.max(var_302_11, arg_299_1.talkMaxDuration)

			if var_302_10 <= arg_299_1.time_ and arg_299_1.time_ < var_302_10 + var_302_15 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_10) / var_302_15

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_10 + var_302_15 and arg_299_1.time_ < var_302_10 + var_302_15 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
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
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play939012074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 939012074
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play939012075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1012ui_story = arg_303_1.actors_["1012ui_story"].transform.localPosition
			end

			local var_306_0 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 then
				arg_303_1.actors_["1012ui_story"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1012ui_story, Vector3.New(-0.7, -1.05, -6.24), (arg_303_1.time_ - 0) / var_306_0)
				arg_303_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1012ui_story"].transform.position).z)
				arg_303_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1012ui_story"].transform.localEulerAngles = arg_303_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 then
				arg_303_1.actors_["1012ui_story"].transform.localPosition = Vector3.New(-0.7, -1.05, -6.24)
				arg_303_1.actors_["1012ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_303_1.actors_["1012ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1012ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_303_1.actors_["1012ui_story"].transform.position).z)
				arg_303_1.actors_["1012ui_story"].transform.localEulerAngles.z = 0
				arg_303_1.actors_["1012ui_story"].transform.localEulerAngles.x = 0
				arg_303_1.actors_["1012ui_story"].transform.localEulerAngles = arg_303_1.actors_["1012ui_story"].transform.localEulerAngles
			end

			local var_306_1 = arg_303_1.actors_["1054ui_story"].transform

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1054ui_story = var_306_1.localPosition

				local var_306_2 = GameObjectTools.GetOrAddComponent(var_306_1.gameObject, typeof(DynamicBoneHelper))

				if var_306_2 then
					var_306_2:EnableDynamicBone(false)
				end
			end

			local var_306_3 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_3 then
				var_306_1.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_303_1.time_ - 0) / var_306_3)
				var_306_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_306_1.position).x, (manager.ui.mainCamera.transform.position - var_306_1.position).y, (manager.ui.mainCamera.transform.position - var_306_1.position).z)
				var_306_1.localEulerAngles.z = 0
				var_306_1.localEulerAngles.x = 0
				var_306_1.localEulerAngles = var_306_1.localEulerAngles
			end

			if arg_303_1.time_ >= 0 + var_306_3 and arg_303_1.time_ < 0 + var_306_3 + arg_306_0 then
				var_306_1.localPosition = Vector3.New(0, 100, 0)
				var_306_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_306_1.position).x, (manager.ui.mainCamera.transform.position - var_306_1.position).y, (manager.ui.mainCamera.transform.position - var_306_1.position).z)
				var_306_1.localEulerAngles.z = 0
				var_306_1.localEulerAngles.x = 0
				var_306_1.localEulerAngles = var_306_1.localEulerAngles

				local var_306_4 = GameObjectTools.GetOrAddComponent(var_306_1.gameObject, typeof(DynamicBoneHelper))

				if var_306_4 then
					var_306_4:EnableDynamicBone(true)
				end
			end

			local var_306_5 = arg_303_1.actors_["1012ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_5) and arg_303_1.var_.characterEffect1012ui_story == nil then
				arg_303_1.var_.characterEffect1012ui_story = var_306_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_6 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_6 and not isNil(var_306_5) then
				if arg_303_1.var_.characterEffect1012ui_story and not isNil(var_306_5) then
					arg_303_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= 0 + var_306_6 and arg_303_1.time_ < 0 + var_306_6 + arg_306_0 and not isNil(var_306_5) and arg_303_1.var_.characterEffect1012ui_story then
				arg_303_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_306_8 = arg_303_1.actors_["6148ui_story"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_8) and arg_303_1.var_.characterEffect6148ui_story == nil then
				arg_303_1.var_.characterEffect6148ui_story = var_306_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_9 = 0.200000002980232

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_9 and not isNil(var_306_8) then
				if arg_303_1.var_.characterEffect6148ui_story and not isNil(var_306_8) then
					arg_303_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_303_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_303_1.time_ - 0) / var_306_9)
				end
			end

			if arg_303_1.time_ >= 0 + var_306_9 and arg_303_1.time_ < 0 + var_306_9 + arg_306_0 and not isNil(var_306_8) and arg_303_1.var_.characterEffect6148ui_story then
				arg_303_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_303_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/story1012/story1012action/1012action1_1")
			end

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1:PlayTimeline("1012ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_306_10 = 0
			local var_306_11 = 0.3

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_10 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_12 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(939012074).content)

				arg_303_1.text_.text = var_306_12

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_14 = 12 <= 0 and var_306_11 or var_306_11 * (utf8.len(var_306_12) / 12)

				if (12 <= 0 and var_306_11 or var_306_11 * (utf8.len(var_306_12) / 12)) > 0 and var_306_11 < var_306_14 then
					arg_303_1.talkMaxDuration = var_306_14

					if var_306_14 + var_306_10 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_14 + var_306_10
					end
				end

				arg_303_1.text_.text = var_306_12
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_15 = math.max(var_306_11, arg_303_1.talkMaxDuration)

			if var_306_10 <= arg_303_1.time_ and arg_303_1.time_ < var_306_10 + var_306_15 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_10) / var_306_15

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_10 + var_306_15 and arg_303_1.time_ < var_306_10 + var_306_15 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012ui_story",
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

		arg_303_1:InitPlayNodeList()
	end,
	Play939012075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 939012075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play939012076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["1012ui_story"]) and arg_307_1.var_.characterEffect1012ui_story == nil then
				arg_307_1.var_.characterEffect1012ui_story = arg_307_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["1012ui_story"]) then
				if arg_307_1.var_.characterEffect1012ui_story and not isNil(arg_307_1.actors_["1012ui_story"]) then
					arg_307_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_307_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_307_1.time_ - 0) / var_310_0)
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["1012ui_story"]) and arg_307_1.var_.characterEffect1012ui_story then
				arg_307_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_307_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_310_1 = 0
			local var_310_2 = 0.775

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_3 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(939012075).content)

				arg_307_1.text_.text = var_310_3

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 31 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_3) / 31)

				if (31 <= 0 and var_310_2 or var_310_2 * (utf8.len(var_310_3) / 31)) > 0 and var_310_2 < var_310_5 then
					arg_307_1.talkMaxDuration = var_310_5

					if var_310_5 + var_310_1 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_5 + var_310_1
					end
				end

				arg_307_1.text_.text = var_310_3
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_6 = math.max(var_310_2, arg_307_1.talkMaxDuration)

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_6 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_1) / var_310_6

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_1 + var_310_6 and arg_307_1.time_ < var_310_1 + var_310_6 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play939012076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 939012076
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play939012077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.75

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_1 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(939012076).content)

				arg_311_1.text_.text = var_314_1

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_3 = 30 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 30)

				if (30 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 30)) > 0 and var_314_0 < var_314_3 then
					arg_311_1.talkMaxDuration = var_314_3

					if var_314_3 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_3 + 0
					end
				end

				arg_311_1.text_.text = var_314_1
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_4 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_4 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_4

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_4 and arg_311_1.time_ < 0 + var_314_4 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play939012077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 939012077
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
			arg_315_1.auto_ = false
		end

		function arg_315_1.playNext_(arg_317_0)
			arg_315_1.onStoryFinished_()
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.marker = "luntantiezi2"
				arg_315_1.actionList["1"] = arg_315_1.actionList["1"] or StoryInteractionRogueCardForumGame.New(arg_315_1, "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI")

				arg_315_1.actionList["1"]:SetData({
					hideOnEndGame = false,
					type = 2,
					postId = 201,
					enterClipName = "",
					completeShowStoryUI = false,
					isNeedInteraction = true,
					uiBtnName = "postBtn_",
					enterHideStoryUI = true,
					completeClipName = "",
					enterController = {},
					completeController = {}
				})
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I05a"
	},
	voices = {},
	skipMarkers = {
		939012077
	}
}
