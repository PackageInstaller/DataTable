return {
	Play325602001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 325602001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play325602002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J25f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J25f")
				var_4_0.name = "J25f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J25f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J25f

				arg_1_1.bgs_.J25f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J25f" then
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_121_00", "se_story_121_00_dooropen_loop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_1_story_boss", "bgm_activity_5_1_story_boss", "bgm_activity_5_1_story_boss.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_activity_5_1_story_boss", "bgm_activity_5_1_story_boss")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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

			local var_4_13 = 2
			local var_4_14 = 0.9

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_15 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_15:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_16 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(325602001).content)

				arg_1_1.text_.text = var_4_16

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_18 = 36 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 36)

				if (36 <= 0 and var_4_14 or var_4_14 * (utf8.len(var_4_16) / 36)) > 0 and var_4_14 < var_4_18 then
					arg_1_1.talkMaxDuration = var_4_18
					var_4_13 = var_4_13 + 0.3

					if var_4_18 + var_4_13 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_18 + var_4_13
					end
				end

				arg_1_1.text_.text = var_4_16
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_13 + 0.3
			local var_4_20 = math.max(var_4_14, arg_1_1.talkMaxDuration)

			if var_4_13 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play325602002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 325602002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play325602003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 1.125

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(325602002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 45 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 45)

				if (45 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 45)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play325602003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 325602003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play325602004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 1.775

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(325602003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 71 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 71)

				if (71 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 71)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play325602004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 325602004
		arg_16_1.duration_ = 2.2

		local var_16_0 = {
			zh = 2.2,
			ja = 1.999999999999
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play325602005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["10170ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10170ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "10170ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "10170ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["10170ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["10170ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["10170ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["10170ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["10170ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos10170ui_story = var_19_3.localPosition

				local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_3.gameObject, typeof(DynamicBoneHelper))

				if var_19_4 then
					var_19_4:EnableDynamicBone(false)
				end
			end

			local var_19_5 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_5 then
				var_19_3.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10170ui_story, Vector3.New(0, -1.03, -6.05), (arg_16_1.time_ - 0) / var_19_5)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_5 and arg_16_1.time_ < 0 + var_19_5 + arg_19_0 then
				var_19_3.localPosition = Vector3.New(0, -1.03, -6.05)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles

				local var_19_6 = GameObjectTools.GetOrAddComponent(var_19_3.gameObject, typeof(DynamicBoneHelper))

				if var_19_6 then
					var_19_6:EnableDynamicBone(true)
				end
			end

			local var_19_7 = arg_16_1.actors_["10170ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_7) and arg_16_1.var_.characterEffect10170ui_story == nil then
				arg_16_1.var_.characterEffect10170ui_story = var_19_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_8 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_8 and not isNil(var_19_7) then
				if arg_16_1.var_.characterEffect10170ui_story and not isNil(var_19_7) then
					arg_16_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_8 and arg_16_1.time_ < 0 + var_19_8 + arg_19_0 and not isNil(var_19_7) and arg_16_1.var_.characterEffect10170ui_story then
				arg_16_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_19_10 = 0
			local var_19_11 = 0.225

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_12 = arg_16_1:GetWordFromCfg(325602004)
				local var_19_13 = arg_16_1:FormatText(var_19_12.content)

				arg_16_1.text_.text = var_19_13

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_15 = 9 <= 0 and var_19_11 or var_19_11 * (utf8.len(var_19_13) / 9)

				if (9 <= 0 and var_19_11 or var_19_11 * (utf8.len(var_19_13) / 9)) > 0 and var_19_11 < var_19_15 then
					arg_16_1.talkMaxDuration = var_19_15

					if var_19_15 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_15 + var_19_10
					end
				end

				arg_16_1.text_.text = var_19_13
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602004", "story_v_out_325602.awb") ~= 0 then
					local var_19_16 = manager.audio:GetVoiceLength("story_v_out_325602", "325602004", "story_v_out_325602.awb") / 1000

					if var_19_16 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_16 + var_19_10
					end

					if var_19_12.prefab_name ~= "" and arg_16_1.actors_[var_19_12.prefab_name] ~= nil then
						local var_19_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_12.prefab_name].transform, "story_v_out_325602", "325602004", "story_v_out_325602.awb")

						arg_16_1:RecordAudio("325602004", var_19_17)
						arg_16_1:RecordAudio("325602004", var_19_17)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_325602", "325602004", "story_v_out_325602.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_325602", "325602004", "story_v_out_325602.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_18 = math.max(var_19_11, arg_16_1.talkMaxDuration)

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_18 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_10) / var_19_18

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_10 + var_19_18 and arg_16_1.time_ < var_19_10 + var_19_18 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play325602005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 325602005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play325602006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos10170ui_story = arg_20_1.actors_["10170ui_story"].transform.localPosition

				local var_23_0 = GameObjectTools.GetOrAddComponent(arg_20_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_23_0 then
					var_23_0:EnableDynamicBone(false)
				end
			end

			local var_23_1 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_1 then
				arg_20_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_1)
				arg_20_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["10170ui_story"].transform.position).z)
				arg_20_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["10170ui_story"].transform.localEulerAngles = arg_20_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_1 and arg_20_1.time_ < 0 + var_23_1 + arg_23_0 then
				arg_20_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["10170ui_story"].transform.position).z)
				arg_20_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["10170ui_story"].transform.localEulerAngles = arg_20_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_23_2 = GameObjectTools.GetOrAddComponent(arg_20_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(true)
				end
			end

			local var_23_3 = arg_20_1.actors_["10170ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect10170ui_story == nil then
				arg_20_1.var_.characterEffect10170ui_story = var_23_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_4 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 and not isNil(var_23_3) then
				if arg_20_1.var_.characterEffect10170ui_story and not isNil(var_23_3) then
					arg_20_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_20_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_4)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect10170ui_story then
				arg_20_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_20_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_23_5 = 0
			local var_23_6 = 0.725

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_7 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(325602005).content)

				arg_20_1.text_.text = var_23_7

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_9 = 29 <= 0 and var_23_6 or var_23_6 * (utf8.len(var_23_7) / 29)

				if (29 <= 0 and var_23_6 or var_23_6 * (utf8.len(var_23_7) / 29)) > 0 and var_23_6 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_5 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_5
					end
				end

				arg_20_1.text_.text = var_23_7
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_6, arg_20_1.talkMaxDuration)

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_5) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_5 + var_23_10 and arg_20_1.time_ < var_23_5 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
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
	Play325602006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 325602006
		arg_24_1.duration_ = 3.17

		local var_24_0 = {
			zh = 2.4,
			ja = 3.166
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play325602007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos10170ui_story = arg_24_1.actors_["10170ui_story"].transform.localPosition

				local var_27_0 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_0 then
					var_27_0:EnableDynamicBone(false)
				end
			end

			local var_27_1 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_1 then
				arg_24_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10170ui_story, Vector3.New(0, -1.03, -6.05), (arg_24_1.time_ - 0) / var_27_1)
				arg_24_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["10170ui_story"].transform.position).z)
				arg_24_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["10170ui_story"].transform.localEulerAngles = arg_24_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_1 and arg_24_1.time_ < 0 + var_27_1 + arg_27_0 then
				arg_24_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, -1.03, -6.05)
				arg_24_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["10170ui_story"].transform.position).z)
				arg_24_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["10170ui_story"].transform.localEulerAngles = arg_24_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_27_2 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(true)
				end
			end

			local var_27_3 = arg_24_1.actors_["10170ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect10170ui_story == nil then
				arg_24_1.var_.characterEffect10170ui_story = var_27_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_4 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 and not isNil(var_27_3) then
				if arg_24_1.var_.characterEffect10170ui_story and not isNil(var_27_3) then
					arg_24_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect10170ui_story then
				arg_24_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_27_6 = 0
			local var_27_7 = 0.25

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_8 = arg_24_1:GetWordFromCfg(325602006)
				local var_27_9 = arg_24_1:FormatText(var_27_8.content)

				arg_24_1.text_.text = var_27_9

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_11 = 10 <= 0 and var_27_7 or var_27_7 * (utf8.len(var_27_9) / 10)

				if (10 <= 0 and var_27_7 or var_27_7 * (utf8.len(var_27_9) / 10)) > 0 and var_27_7 < var_27_11 then
					arg_24_1.talkMaxDuration = var_27_11

					if var_27_11 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_11 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_9
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602006", "story_v_out_325602.awb") ~= 0 then
					local var_27_12 = manager.audio:GetVoiceLength("story_v_out_325602", "325602006", "story_v_out_325602.awb") / 1000

					if var_27_12 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_12 + var_27_6
					end

					if var_27_8.prefab_name ~= "" and arg_24_1.actors_[var_27_8.prefab_name] ~= nil then
						local var_27_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_8.prefab_name].transform, "story_v_out_325602", "325602006", "story_v_out_325602.awb")

						arg_24_1:RecordAudio("325602006", var_27_13)
						arg_24_1:RecordAudio("325602006", var_27_13)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_325602", "325602006", "story_v_out_325602.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_325602", "325602006", "story_v_out_325602.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_14 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_14 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_14

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_14 and arg_24_1.time_ < var_27_6 + var_27_14 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
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
	Play325602007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 325602007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play325602008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos10170ui_story = arg_28_1.actors_["10170ui_story"].transform.localPosition

				local var_31_0 = GameObjectTools.GetOrAddComponent(arg_28_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_31_0 then
					var_31_0:EnableDynamicBone(false)
				end
			end

			local var_31_1 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_1 then
				arg_28_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_1)
				arg_28_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["10170ui_story"].transform.position).z)
				arg_28_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["10170ui_story"].transform.localEulerAngles = arg_28_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_1 and arg_28_1.time_ < 0 + var_31_1 + arg_31_0 then
				arg_28_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["10170ui_story"].transform.position).z)
				arg_28_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["10170ui_story"].transform.localEulerAngles = arg_28_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_31_2 = GameObjectTools.GetOrAddComponent(arg_28_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(true)
				end
			end

			local var_31_3 = arg_28_1.actors_["10170ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_3) and arg_28_1.var_.characterEffect10170ui_story == nil then
				arg_28_1.var_.characterEffect10170ui_story = var_31_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_4 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 and not isNil(var_31_3) then
				if arg_28_1.var_.characterEffect10170ui_story and not isNil(var_31_3) then
					arg_28_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_28_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_4)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 and not isNil(var_31_3) and arg_28_1.var_.characterEffect10170ui_story then
				arg_28_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_28_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_31_5 = 0
			local var_31_6 = 0.1

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_7 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(325602007).content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 4 <= 0 and var_31_6 or var_31_6 * (utf8.len(var_31_7) / 4)

				if (4 <= 0 and var_31_6 or var_31_6 * (utf8.len(var_31_7) / 4)) > 0 and var_31_6 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_5 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_5
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_6, arg_28_1.talkMaxDuration)

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_5) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_5 + var_31_10 and arg_28_1.time_ < var_31_5 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play325602008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 325602008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play325602009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.825

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_1 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(325602008).content)

				arg_32_1.text_.text = var_35_1

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_3 = 33 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 33)

				if (33 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 33)) > 0 and var_35_0 < var_35_3 then
					arg_32_1.talkMaxDuration = var_35_3

					if var_35_3 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_3 + 0
					end
				end

				arg_32_1.text_.text = var_35_1
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_4 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_4

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play325602009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 325602009
		arg_36_1.duration_ = 7.27

		local var_36_0 = {
			zh = 6.5,
			ja = 7.266
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play325602010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_9000

			if arg_36_1.bgs_.J27f == nil then
				local var_39_0 = Object.Instantiate(arg_36_1.paintGo_)

				var_39_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J27f")
				var_39_0.name = "J27f"
				var_39_0.transform.parent = arg_36_1.stage_.transform
				var_39_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.bgs_.J27f = var_39_0
			end

			if 1.13333333333333 < arg_36_1.time_ and arg_36_1.time_ <= 1.13333333333333 + arg_39_0 then
				local var_39_1 = arg_36_1.bgs_.J27f

				arg_36_1.bgs_.J27f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_39_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_39_2 = var_39_1:GetComponent("SpriteRenderer")

				if var_39_2 and var_39_2.sprite then
					local var_39_3 = 2 * (var_39_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_39_1.transform.localScale = Vector3.New(var_39_3 / var_39_2.sprite.bounds.size.y < var_39_3 * manager.ui.mainCameraCom_.aspect / var_39_2.sprite.bounds.size.x and var_39_3 * manager.ui.mainCameraCom_.aspect / var_39_2.sprite.bounds.size.x or var_39_3 / var_39_2.sprite.bounds.size.y, var_39_3 / var_39_2.sprite.bounds.size.y < var_39_3 * manager.ui.mainCameraCom_.aspect / var_39_2.sprite.bounds.size.x and var_39_3 * manager.ui.mainCameraCom_.aspect / var_39_2.sprite.bounds.size.x or var_39_3 / var_39_2.sprite.bounds.size.y, 0)
				end

				for iter_39_0, iter_39_1 in pairs(arg_36_1.bgs_) do
					if iter_39_0 ~= "J27f" then
						iter_39_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_39_4 = 2

			if 2 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.allBtn_.enabled = false
			end

			if arg_36_1.time_ >= var_39_4 + 0.3 and arg_36_1.time_ < var_39_4 + 0.3 + arg_39_0 then
				arg_36_1.allBtn_.enabled = true
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				local var_39_5 = arg_36_1.var_.effectshunjianhuiyi1

				if not arg_36_1.var_.effectshunjianhuiyi1 then
					var_39_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_39_5.name = "shunjianhuiyi1"
					arg_36_1.var_.effectshunjianhuiyi1 = var_39_5
				else
					var_39_5.transform:SetParent(var_39_9000)
				end

				var_39_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_39_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_39_7 = arg_36_1.actors_["10170ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos10170ui_story = var_39_7.localPosition

				local var_39_8 = GameObjectTools.GetOrAddComponent(var_39_7.gameObject, typeof(DynamicBoneHelper))

				if var_39_8 then
					var_39_8:EnableDynamicBone(false)
				end
			end

			local var_39_9 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_9 then
				var_39_7.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_9)
				var_39_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_7.position).x, (manager.ui.mainCamera.transform.position - var_39_7.position).y, (manager.ui.mainCamera.transform.position - var_39_7.position).z)
				var_39_7.localEulerAngles.z = 0
				var_39_7.localEulerAngles.x = 0
				var_39_7.localEulerAngles = var_39_7.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_9 and arg_36_1.time_ < 0 + var_39_9 + arg_39_0 then
				var_39_7.localPosition = Vector3.New(0, 100, 0)
				var_39_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_7.position).x, (manager.ui.mainCamera.transform.position - var_39_7.position).y, (manager.ui.mainCamera.transform.position - var_39_7.position).z)
				var_39_7.localEulerAngles.z = 0
				var_39_7.localEulerAngles.x = 0
				var_39_7.localEulerAngles = var_39_7.localEulerAngles

				local var_39_10 = GameObjectTools.GetOrAddComponent(var_39_7.gameObject, typeof(DynamicBoneHelper))

				if var_39_10 then
					var_39_10:EnableDynamicBone(true)
				end
			end

			local var_39_11 = arg_36_1.actors_["10170ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_11) and arg_36_1.var_.characterEffect10170ui_story == nil then
				arg_36_1.var_.characterEffect10170ui_story = var_39_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_12 = 0.034000001847744

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_12 and not isNil(var_39_11) then
				if arg_36_1.var_.characterEffect10170ui_story and not isNil(var_39_11) then
					arg_36_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_12 and arg_36_1.time_ < 0 + var_39_12 + arg_39_0 and not isNil(var_39_11) and arg_36_1.var_.characterEffect10170ui_story then
				arg_36_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_39_14 = arg_36_1.actors_["10170ui_story"].transform

			if 1.7 < arg_36_1.time_ and arg_36_1.time_ <= 1.7 + arg_39_0 then
				arg_36_1.var_.moveOldPos10170ui_story = var_39_14.localPosition

				local var_39_15 = GameObjectTools.GetOrAddComponent(var_39_14.gameObject, typeof(DynamicBoneHelper))

				if var_39_15 then
					var_39_15:EnableDynamicBone(false)
				end
			end

			local var_39_16 = 0.001

			if 1.7 <= arg_36_1.time_ and arg_36_1.time_ < 1.7 + var_39_16 then
				var_39_14.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos10170ui_story, Vector3.New(0, -1.03, -6.05), (arg_36_1.time_ - 1.7) / var_39_16)
				var_39_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_14.position).x, (manager.ui.mainCamera.transform.position - var_39_14.position).y, (manager.ui.mainCamera.transform.position - var_39_14.position).z)
				var_39_14.localEulerAngles.z = 0
				var_39_14.localEulerAngles.x = 0
				var_39_14.localEulerAngles = var_39_14.localEulerAngles
			end

			if arg_36_1.time_ >= 1.7 + var_39_16 and arg_36_1.time_ < 1.7 + var_39_16 + arg_39_0 then
				var_39_14.localPosition = Vector3.New(0, -1.03, -6.05)
				var_39_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_14.position).x, (manager.ui.mainCamera.transform.position - var_39_14.position).y, (manager.ui.mainCamera.transform.position - var_39_14.position).z)
				var_39_14.localEulerAngles.z = 0
				var_39_14.localEulerAngles.x = 0
				var_39_14.localEulerAngles = var_39_14.localEulerAngles

				local var_39_17 = GameObjectTools.GetOrAddComponent(var_39_14.gameObject, typeof(DynamicBoneHelper))

				if var_39_17 then
					var_39_17:EnableDynamicBone(true)
				end
			end

			local var_39_18 = arg_36_1.actors_["10170ui_story"]

			if 1.7 < arg_36_1.time_ and arg_36_1.time_ <= 1.7 + arg_39_0 and not isNil(var_39_18) and arg_36_1.var_.characterEffect10170ui_story == nil then
				arg_36_1.var_.characterEffect10170ui_story = var_39_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_19 = 0.200000002980232

			if 1.7 <= arg_36_1.time_ and arg_36_1.time_ < 1.7 + var_39_19 and not isNil(var_39_18) then
				if arg_36_1.var_.characterEffect10170ui_story and not isNil(var_39_18) then
					arg_36_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 1.7 + var_39_19 and arg_36_1.time_ < 1.7 + var_39_19 + arg_39_0 and not isNil(var_39_18) and arg_36_1.var_.characterEffect10170ui_story then
				arg_36_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 1.7 < arg_36_1.time_ and arg_36_1.time_ <= 1.7 + arg_39_0 then
				arg_36_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			if 1.7 < arg_36_1.time_ and arg_36_1.time_ <= 1.7 + arg_39_0 then
				arg_36_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_39_21 = 1.11666666666667

			arg_36_1.isInRecall_ = true

			if var_39_21 < arg_36_1.time_ and arg_36_1.time_ <= var_39_21 + arg_39_0 then
				arg_36_1.screenFilterGo_:SetActive(true)

				arg_36_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile.asset")
				arg_36_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_36_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_39_2, iter_39_3 in pairs(arg_36_1.actors_) do
					for iter_39_4, iter_39_5 in ipairs((iter_39_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_39_5.color = iter_39_5.color.r > 0.51 and Color.New(0.82, 0.77, 0.62) or Color.New(0.46, 0.43, 0.35)
					end
				end
			end

			local var_39_22 = 0.0166666666666667

			if var_39_21 <= arg_36_1.time_ and arg_36_1.time_ < var_39_21 + var_39_22 then
				arg_36_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_36_1.time_ - var_39_21) / var_39_22)
			end

			if arg_36_1.time_ >= var_39_21 + var_39_22 and arg_36_1.time_ < var_39_21 + var_39_22 + arg_39_0 then
				arg_36_1.screenFilterEffect_.weight = 1
			end

			if arg_36_1.frameCnt_ <= 1 then
				arg_36_1.dialog_:SetActive(false)
			end

			local var_39_23 = 2
			local var_39_24 = 0.575

			if 2 < arg_36_1.time_ and arg_36_1.time_ <= var_39_23 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0

				arg_36_1.dialog_:SetActive(true)

				arg_36_1.dialogCg_.alpha = 0

				local var_39_25 = LeanTween.value(arg_36_1.dialog_, 0, 1, 0.3)

				var_39_25:setOnUpdate(LuaHelper.FloatAction(function(arg_40_0)
					arg_36_1.dialogCg_.alpha = arg_40_0
				end))
				var_39_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_36_1.dialog_)
					var_39_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_36_1.duration_ = arg_36_1.duration_ + 0.3

				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_26 = arg_36_1:GetWordFromCfg(325602009)
				local var_39_27 = arg_36_1:FormatText(var_39_26.content)

				arg_36_1.text_.text = var_39_27

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_29 = 23 <= 0 and var_39_24 or var_39_24 * (utf8.len(var_39_27) / 23)

				if (23 <= 0 and var_39_24 or var_39_24 * (utf8.len(var_39_27) / 23)) > 0 and var_39_24 < var_39_29 then
					arg_36_1.talkMaxDuration = var_39_29
					var_39_23 = var_39_23 + 0.3

					if var_39_29 + var_39_23 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_29 + var_39_23
					end
				end

				arg_36_1.text_.text = var_39_27
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602009", "story_v_out_325602.awb") ~= 0 then
					local var_39_30 = manager.audio:GetVoiceLength("story_v_out_325602", "325602009", "story_v_out_325602.awb") / 1000

					if var_39_30 + var_39_23 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_30 + var_39_23
					end

					if var_39_26.prefab_name ~= "" and arg_36_1.actors_[var_39_26.prefab_name] ~= nil then
						local var_39_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_26.prefab_name].transform, "story_v_out_325602", "325602009", "story_v_out_325602.awb")

						arg_36_1:RecordAudio("325602009", var_39_31)
						arg_36_1:RecordAudio("325602009", var_39_31)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_325602", "325602009", "story_v_out_325602.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_325602", "325602009", "story_v_out_325602.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_32 = var_39_23 + 0.3
			local var_39_33 = math.max(var_39_24, arg_36_1.talkMaxDuration)

			if var_39_23 + 0.3 <= arg_36_1.time_ and arg_36_1.time_ < var_39_32 + var_39_33 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_32) / var_39_33

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_32 + var_39_33 and arg_36_1.time_ < var_39_32 + var_39_33 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play325602010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 325602010
		arg_42_1.duration_ = 6.83

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play325602011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_9000

			if 0.983333333333333 < arg_42_1.time_ and arg_42_1.time_ <= 0.983333333333333 + arg_45_0 then
				local var_45_0 = arg_42_1.bgs_.J25f

				arg_42_1.bgs_.J25f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_45_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_45_1 = var_45_0:GetComponent("SpriteRenderer")

				if var_45_1 and var_45_1.sprite then
					local var_45_2 = 2 * (var_45_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_45_0.transform.localScale = Vector3.New(var_45_2 / var_45_1.sprite.bounds.size.y < var_45_2 * manager.ui.mainCameraCom_.aspect / var_45_1.sprite.bounds.size.x and var_45_2 * manager.ui.mainCameraCom_.aspect / var_45_1.sprite.bounds.size.x or var_45_2 / var_45_1.sprite.bounds.size.y, var_45_2 / var_45_1.sprite.bounds.size.y < var_45_2 * manager.ui.mainCameraCom_.aspect / var_45_1.sprite.bounds.size.x and var_45_2 * manager.ui.mainCameraCom_.aspect / var_45_1.sprite.bounds.size.x or var_45_2 / var_45_1.sprite.bounds.size.y, 0)
				end

				for iter_45_0, iter_45_1 in pairs(arg_42_1.bgs_) do
					if iter_45_0 ~= "J25f" then
						iter_45_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_45_3 = 2

			if 2 < arg_42_1.time_ and arg_42_1.time_ <= var_45_3 + arg_45_0 then
				arg_42_1.allBtn_.enabled = false
			end

			if arg_42_1.time_ >= var_45_3 + 0.3 and arg_42_1.time_ < var_45_3 + 0.3 + arg_45_0 then
				arg_42_1.allBtn_.enabled = true
			end

			local var_45_4 = arg_42_1.actors_["10170ui_story"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos10170ui_story = var_45_4.localPosition

				local var_45_5 = GameObjectTools.GetOrAddComponent(var_45_4.gameObject, typeof(DynamicBoneHelper))

				if var_45_5 then
					var_45_5:EnableDynamicBone(false)
				end
			end

			local var_45_6 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_6 then
				var_45_4.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_42_1.time_ - 0) / var_45_6)
				var_45_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_4.position).x, (manager.ui.mainCamera.transform.position - var_45_4.position).y, (manager.ui.mainCamera.transform.position - var_45_4.position).z)
				var_45_4.localEulerAngles.z = 0
				var_45_4.localEulerAngles.x = 0
				var_45_4.localEulerAngles = var_45_4.localEulerAngles
			end

			if arg_42_1.time_ >= 0 + var_45_6 and arg_42_1.time_ < 0 + var_45_6 + arg_45_0 then
				var_45_4.localPosition = Vector3.New(0, 100, 0)
				var_45_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_45_4.position).x, (manager.ui.mainCamera.transform.position - var_45_4.position).y, (manager.ui.mainCamera.transform.position - var_45_4.position).z)
				var_45_4.localEulerAngles.z = 0
				var_45_4.localEulerAngles.x = 0
				var_45_4.localEulerAngles = var_45_4.localEulerAngles

				local var_45_7 = GameObjectTools.GetOrAddComponent(var_45_4.gameObject, typeof(DynamicBoneHelper))

				if var_45_7 then
					var_45_7:EnableDynamicBone(true)
				end
			end

			local var_45_8 = arg_42_1.actors_["10170ui_story"]

			if 2 < arg_42_1.time_ and arg_42_1.time_ <= 2 + arg_45_0 and not isNil(var_45_8) and arg_42_1.var_.characterEffect10170ui_story == nil then
				arg_42_1.var_.characterEffect10170ui_story = var_45_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_9 = 0.200000002980232

			if 2 <= arg_42_1.time_ and arg_42_1.time_ < 2 + var_45_9 and not isNil(var_45_8) then
				if arg_42_1.var_.characterEffect10170ui_story and not isNil(var_45_8) then
					arg_42_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_42_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_42_1.time_ - 2) / var_45_9)
				end
			end

			if arg_42_1.time_ >= 2 + var_45_9 and arg_42_1.time_ < 2 + var_45_9 + arg_45_0 and not isNil(var_45_8) and arg_42_1.var_.characterEffect10170ui_story then
				arg_42_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_42_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				local var_45_10 = arg_42_1.var_.effectshunjianhuiyi1

				if not arg_42_1.var_.effectshunjianhuiyi1 then
					var_45_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_45_10.name = "shunjianhuiyi1"
					arg_42_1.var_.effectshunjianhuiyi1 = var_45_10
				else
					var_45_10.transform:SetParent(var_45_9000)
				end

				var_45_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_45_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_45_12 = 0.983333333333333

			arg_42_1.isInRecall_ = false

			if var_45_12 < arg_42_1.time_ and arg_42_1.time_ <= var_45_12 + arg_45_0 then
				arg_42_1.screenFilterGo_:SetActive(false)

				for iter_45_2, iter_45_3 in pairs(arg_42_1.actors_) do
					for iter_45_4, iter_45_5 in ipairs((iter_45_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_45_5.color = iter_45_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_45_13 = 0.0166666666666667

			if var_45_12 <= arg_42_1.time_ and arg_42_1.time_ < var_45_12 + var_45_13 then
				arg_42_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_42_1.time_ - var_45_12) / var_45_13)
			end

			if arg_42_1.time_ >= var_45_12 + var_45_13 and arg_42_1.time_ < var_45_12 + var_45_13 + arg_45_0 then
				arg_42_1.screenFilterEffect_.weight = 0
			end

			if arg_42_1.frameCnt_ <= 1 then
				arg_42_1.dialog_:SetActive(false)
			end

			local var_45_14 = 1.83333333333333
			local var_45_15 = 0.05

			if 1.83333333333333 < arg_42_1.time_ and arg_42_1.time_ <= var_45_14 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				arg_42_1.dialog_:SetActive(true)

				arg_42_1.dialogCg_.alpha = 0

				local var_45_16 = LeanTween.value(arg_42_1.dialog_, 0, 1, 0.3)

				var_45_16:setOnUpdate(LuaHelper.FloatAction(function(arg_46_0)
					arg_42_1.dialogCg_.alpha = arg_46_0
				end))
				var_45_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_42_1.dialog_)
					var_45_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_42_1.duration_ = arg_42_1.duration_ + 0.3

				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_17 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(325602010).content)

				arg_42_1.text_.text = var_45_17

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_19 = 2 <= 0 and var_45_15 or var_45_15 * (utf8.len(var_45_17) / 2)

				if (2 <= 0 and var_45_15 or var_45_15 * (utf8.len(var_45_17) / 2)) > 0 and var_45_15 < var_45_19 then
					arg_42_1.talkMaxDuration = var_45_19
					var_45_14 = var_45_14 + 0.3

					if var_45_19 + var_45_14 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_19 + var_45_14
					end
				end

				arg_42_1.text_.text = var_45_17
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_20 = var_45_14 + 0.3
			local var_45_21 = math.max(var_45_15, arg_42_1.talkMaxDuration)

			if var_45_14 + 0.3 <= arg_42_1.time_ and arg_42_1.time_ < var_45_20 + var_45_21 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_20) / var_45_21

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_20 + var_45_21 and arg_42_1.time_ < var_45_20 + var_45_21 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play325602011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 325602011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play325602012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 1.375

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_1 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(325602011).content)

				arg_48_1.text_.text = var_51_1

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_3 = 55 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 55)

				if (55 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 55)) > 0 and var_51_0 < var_51_3 then
					arg_48_1.talkMaxDuration = var_51_3

					if var_51_3 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_3 + 0
					end
				end

				arg_48_1.text_.text = var_51_1
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_4 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_4

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play325602012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 325602012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play325602013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.15

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_1 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(325602012).content)

				arg_52_1.text_.text = var_55_1

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_3 = 6 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 6)

				if (6 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 6)) > 0 and var_55_0 < var_55_3 then
					arg_52_1.talkMaxDuration = var_55_3

					if var_55_3 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_3 + 0
					end
				end

				arg_52_1.text_.text = var_55_1
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_4 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_4

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play325602013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 325602013
		arg_56_1.duration_ = 4.57

		local var_56_0 = {
			zh = 1.833,
			ja = 4.566
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play325602014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos10170ui_story = arg_56_1.actors_["10170ui_story"].transform.localPosition

				local var_59_0 = GameObjectTools.GetOrAddComponent(arg_56_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_59_0 then
					var_59_0:EnableDynamicBone(false)
				end
			end

			local var_59_1 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_1 then
				arg_56_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10170ui_story, Vector3.New(0, -1.03, -6.05), (arg_56_1.time_ - 0) / var_59_1)
				arg_56_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10170ui_story"].transform.position).z)
				arg_56_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["10170ui_story"].transform.localEulerAngles = arg_56_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_1 and arg_56_1.time_ < 0 + var_59_1 + arg_59_0 then
				arg_56_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, -1.03, -6.05)
				arg_56_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_56_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_56_1.actors_["10170ui_story"].transform.position).z)
				arg_56_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_56_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_56_1.actors_["10170ui_story"].transform.localEulerAngles = arg_56_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_59_2 = GameObjectTools.GetOrAddComponent(arg_56_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_59_2 then
					var_59_2:EnableDynamicBone(true)
				end
			end

			local var_59_3 = arg_56_1.actors_["10170ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_3) and arg_56_1.var_.characterEffect10170ui_story == nil then
				arg_56_1.var_.characterEffect10170ui_story = var_59_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_4 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 and not isNil(var_59_3) then
				if arg_56_1.var_.characterEffect10170ui_story and not isNil(var_59_3) then
					arg_56_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 and not isNil(var_59_3) and arg_56_1.var_.characterEffect10170ui_story then
				arg_56_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_59_6 = 0
			local var_59_7 = 0.15

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_8 = arg_56_1:GetWordFromCfg(325602013)
				local var_59_9 = arg_56_1:FormatText(var_59_8.content)

				arg_56_1.text_.text = var_59_9

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 6 <= 0 and var_59_7 or var_59_7 * (utf8.len(var_59_9) / 6)

				if (6 <= 0 and var_59_7 or var_59_7 * (utf8.len(var_59_9) / 6)) > 0 and var_59_7 < var_59_11 then
					arg_56_1.talkMaxDuration = var_59_11

					if var_59_11 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_11 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_9
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602013", "story_v_out_325602.awb") ~= 0 then
					local var_59_12 = manager.audio:GetVoiceLength("story_v_out_325602", "325602013", "story_v_out_325602.awb") / 1000

					if var_59_12 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_12 + var_59_6
					end

					if var_59_8.prefab_name ~= "" and arg_56_1.actors_[var_59_8.prefab_name] ~= nil then
						local var_59_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_8.prefab_name].transform, "story_v_out_325602", "325602013", "story_v_out_325602.awb")

						arg_56_1:RecordAudio("325602013", var_59_13)
						arg_56_1:RecordAudio("325602013", var_59_13)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_325602", "325602013", "story_v_out_325602.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_325602", "325602013", "story_v_out_325602.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_14 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_14 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_14

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_14 and arg_56_1.time_ < var_59_6 + var_59_14 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
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
	Play325602014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 325602014
		arg_60_1.duration_ = 4.47

		local var_60_0 = {
			zh = 3.566,
			ja = 4.466
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play325602015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos10170ui_story = arg_60_1.actors_["10170ui_story"].transform.localPosition

				local var_63_0 = GameObjectTools.GetOrAddComponent(arg_60_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_63_0 then
					var_63_0:EnableDynamicBone(false)
				end
			end

			local var_63_1 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_1 then
				arg_60_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_1)
				arg_60_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10170ui_story"].transform.position).z)
				arg_60_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["10170ui_story"].transform.localEulerAngles = arg_60_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_1 and arg_60_1.time_ < 0 + var_63_1 + arg_63_0 then
				arg_60_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["10170ui_story"].transform.position).z)
				arg_60_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["10170ui_story"].transform.localEulerAngles = arg_60_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_63_2 = GameObjectTools.GetOrAddComponent(arg_60_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(true)
				end
			end

			local var_63_3 = "10180ui_story"

			if arg_60_1.actors_["10180ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10180ui_story"))) then
				local var_63_4 = Object.Instantiate(Asset.Load("Char/" .. "10180ui_story"), arg_60_1.stage_.transform)

				var_63_4.name = var_63_3
				var_63_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.actors_[var_63_3] = var_63_4

				local var_63_5 = var_63_4:GetComponentInChildren(typeof(CharacterEffect))

				var_63_5.enabled = true

				local var_63_6 = GameObjectTools.GetOrAddComponent(var_63_4, typeof(DynamicBoneHelper))

				if var_63_6 then
					var_63_6:EnableDynamicBone(false)
				end

				arg_60_1:ShowWeapon(var_63_5.transform, false)

				arg_60_1.var_[var_63_3 .. "Animator"] = var_63_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_60_1.var_[var_63_3 .. "Animator"].applyRootMotion = true
				arg_60_1.var_[var_63_3 .. "LipSync"] = var_63_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_63_7 = arg_60_1.actors_["10180ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos10180ui_story = var_63_7.localPosition

				local var_63_8 = GameObjectTools.GetOrAddComponent(var_63_7.gameObject, typeof(DynamicBoneHelper))

				if var_63_8 then
					var_63_8:EnableDynamicBone(false)
				end
			end

			local var_63_9 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_9 then
				var_63_7.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos10180ui_story, Vector3.New(-0.03, -1.09, -6.14), (arg_60_1.time_ - 0) / var_63_9)
				var_63_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_7.position).x, (manager.ui.mainCamera.transform.position - var_63_7.position).y, (manager.ui.mainCamera.transform.position - var_63_7.position).z)
				var_63_7.localEulerAngles.z = 0
				var_63_7.localEulerAngles.x = 0
				var_63_7.localEulerAngles = var_63_7.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_9 and arg_60_1.time_ < 0 + var_63_9 + arg_63_0 then
				var_63_7.localPosition = Vector3.New(-0.03, -1.09, -6.14)
				var_63_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_7.position).x, (manager.ui.mainCamera.transform.position - var_63_7.position).y, (manager.ui.mainCamera.transform.position - var_63_7.position).z)
				var_63_7.localEulerAngles.z = 0
				var_63_7.localEulerAngles.x = 0
				var_63_7.localEulerAngles = var_63_7.localEulerAngles

				local var_63_10 = GameObjectTools.GetOrAddComponent(var_63_7.gameObject, typeof(DynamicBoneHelper))

				if var_63_10 then
					var_63_10:EnableDynamicBone(true)
				end
			end

			local var_63_11 = arg_60_1.actors_["10180ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_11) and arg_60_1.var_.characterEffect10180ui_story == nil then
				arg_60_1.var_.characterEffect10180ui_story = var_63_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_12 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_12 and not isNil(var_63_11) then
				if arg_60_1.var_.characterEffect10180ui_story and not isNil(var_63_11) then
					arg_60_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_12 and arg_60_1.time_ < 0 + var_63_12 + arg_63_0 and not isNil(var_63_11) and arg_60_1.var_.characterEffect10180ui_story then
				arg_60_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_63_14 = arg_60_1.actors_["10170ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_14) and arg_60_1.var_.characterEffect10170ui_story == nil then
				arg_60_1.var_.characterEffect10170ui_story = var_63_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_15 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_15 and not isNil(var_63_14) then
				if arg_60_1.var_.characterEffect10170ui_story and not isNil(var_63_14) then
					arg_60_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_60_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_15)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_15 and arg_60_1.time_ < 0 + var_63_15 + arg_63_0 and not isNil(var_63_14) and arg_60_1.var_.characterEffect10170ui_story then
				arg_60_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_60_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action1_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_63_16 = 0
			local var_63_17 = 0.15

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_16 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_18 = arg_60_1:GetWordFromCfg(325602014)
				local var_63_19 = arg_60_1:FormatText(var_63_18.content)

				arg_60_1.text_.text = var_63_19

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_21 = 6 <= 0 and var_63_17 or var_63_17 * (utf8.len(var_63_19) / 6)

				if (6 <= 0 and var_63_17 or var_63_17 * (utf8.len(var_63_19) / 6)) > 0 and var_63_17 < var_63_21 then
					arg_60_1.talkMaxDuration = var_63_21

					if var_63_21 + var_63_16 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_21 + var_63_16
					end
				end

				arg_60_1.text_.text = var_63_19
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602014", "story_v_out_325602.awb") ~= 0 then
					local var_63_22 = manager.audio:GetVoiceLength("story_v_out_325602", "325602014", "story_v_out_325602.awb") / 1000

					if var_63_22 + var_63_16 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_22 + var_63_16
					end

					if var_63_18.prefab_name ~= "" and arg_60_1.actors_[var_63_18.prefab_name] ~= nil then
						local var_63_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_18.prefab_name].transform, "story_v_out_325602", "325602014", "story_v_out_325602.awb")

						arg_60_1:RecordAudio("325602014", var_63_23)
						arg_60_1:RecordAudio("325602014", var_63_23)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_325602", "325602014", "story_v_out_325602.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_325602", "325602014", "story_v_out_325602.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_24 = math.max(var_63_17, arg_60_1.talkMaxDuration)

			if var_63_16 <= arg_60_1.time_ and arg_60_1.time_ < var_63_16 + var_63_24 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_16) / var_63_24

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_16 + var_63_24 and arg_60_1.time_ < var_63_16 + var_63_24 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play325602015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 325602015
		arg_64_1.duration_ = 6.67

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play325602016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_9001
			local var_67_9000

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos10180ui_story = arg_64_1.actors_["10180ui_story"].transform.localPosition

				local var_67_0 = GameObjectTools.GetOrAddComponent(arg_64_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_67_0 then
					var_67_0:EnableDynamicBone(false)
				end
			end

			local var_67_1 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_1 then
				arg_64_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_1)
				arg_64_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["10180ui_story"].transform.position).z)
				arg_64_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["10180ui_story"].transform.localEulerAngles = arg_64_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_1 and arg_64_1.time_ < 0 + var_67_1 + arg_67_0 then
				arg_64_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_64_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_64_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_64_1.actors_["10180ui_story"].transform.position).z)
				arg_64_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_64_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_64_1.actors_["10180ui_story"].transform.localEulerAngles = arg_64_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_67_2 = GameObjectTools.GetOrAddComponent(arg_64_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_67_2 then
					var_67_2:EnableDynamicBone(true)
				end
			end

			local var_67_3 = arg_64_1.actors_["10180ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_3) and arg_64_1.var_.characterEffect10180ui_story == nil then
				arg_64_1.var_.characterEffect10180ui_story = var_67_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_4 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 and not isNil(var_67_3) then
				if arg_64_1.var_.characterEffect10180ui_story and not isNil(var_67_3) then
					arg_64_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_4)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 and not isNil(var_67_3) and arg_64_1.var_.characterEffect10180ui_story then
				arg_64_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				local var_67_5 = arg_64_1.var_.effectmantianheiwu1

				if not arg_64_1.var_.effectmantianheiwu1 then
					var_67_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heiwu"), manager.ui.mainCamera.transform)
					var_67_5.name = "mantianheiwu1"
					arg_64_1.var_.effectmantianheiwu1 = var_67_5
				else
					var_67_5.transform:SetParent(var_67_9001)
				end

				var_67_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_67_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				local var_67_7 = arg_64_1.var_.effectmantianheiwu2

				if not arg_64_1.var_.effectmantianheiwu2 then
					var_67_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heimu_keep"), manager.ui.mainCamera.transform)
					var_67_7.name = "mantianheiwu2"
					arg_64_1.var_.effectmantianheiwu2 = var_67_7
				else
					var_67_7.transform:SetParent(var_67_9000)
				end

				var_67_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_67_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.1 < arg_64_1.time_ and arg_64_1.time_ <= 0.1 + arg_67_0 then
				arg_64_1:AudioAction("play", "effect", "se_story_128", "se_story_128_magic", "")
			end

			if 0.1 < arg_64_1.time_ and arg_64_1.time_ <= 0.1 + arg_67_0 then
				arg_64_1:AudioAction("play", "effect", "se_story_143", "se_story_143_magic_fire", "")
			end

			local var_67_11 = 0

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.allBtn_.enabled = false
			end

			if arg_64_1.time_ >= var_67_11 + 2.2 and arg_64_1.time_ < var_67_11 + 2.2 + arg_67_0 then
				arg_64_1.allBtn_.enabled = true
			end

			if arg_64_1.frameCnt_ <= 1 then
				arg_64_1.dialog_:SetActive(false)
			end

			local var_67_12 = 1.66666666666667
			local var_67_13 = 1.4

			if 1.66666666666667 < arg_64_1.time_ and arg_64_1.time_ <= var_67_12 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0

				arg_64_1.dialog_:SetActive(true)

				arg_64_1.dialogCg_.alpha = 0

				local var_67_14 = LeanTween.value(arg_64_1.dialog_, 0, 1, 0.3)

				var_67_14:setOnUpdate(LuaHelper.FloatAction(function(arg_68_0)
					arg_64_1.dialogCg_.alpha = arg_68_0
				end))
				var_67_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_64_1.dialog_)
					var_67_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_64_1.duration_ = arg_64_1.duration_ + 0.3

				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_15 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(325602015).content)

				arg_64_1.text_.text = var_67_15

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_17 = 56 <= 0 and var_67_13 or var_67_13 * (utf8.len(var_67_15) / 56)

				if (56 <= 0 and var_67_13 or var_67_13 * (utf8.len(var_67_15) / 56)) > 0 and var_67_13 < var_67_17 then
					arg_64_1.talkMaxDuration = var_67_17
					var_67_12 = var_67_12 + 0.3

					if var_67_17 + var_67_12 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_17 + var_67_12
					end
				end

				arg_64_1.text_.text = var_67_15
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_18 = var_67_12 + 0.3
			local var_67_19 = math.max(var_67_13, arg_64_1.talkMaxDuration)

			if var_67_12 + 0.3 <= arg_64_1.time_ and arg_64_1.time_ < var_67_18 + var_67_19 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_18) / var_67_19

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_18 + var_67_19 and arg_64_1.time_ < var_67_18 + var_67_19 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
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
	Play325602016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 325602016
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play325602017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 1.45

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_1 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(325602016).content)

				arg_70_1.text_.text = var_73_1

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_3 = 58 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_1) / 58)

				if (58 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_1) / 58)) > 0 and var_73_0 < var_73_3 then
					arg_70_1.talkMaxDuration = var_73_3

					if var_73_3 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_3 + 0
					end
				end

				arg_70_1.text_.text = var_73_1
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_4 = math.max(var_73_0, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - 0) / var_73_4

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play325602017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 325602017
		arg_74_1.duration_ = 4.37

		local var_74_0 = {
			zh = 3.433,
			ja = 4.366
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play325602018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.3

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_1 = arg_74_1:GetWordFromCfg(325602017)
				local var_77_2 = arg_74_1:FormatText(var_77_1.content)

				arg_74_1.text_.text = var_77_2

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 12 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 12)

				if (12 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 12)) > 0 and var_77_0 < var_77_4 then
					arg_74_1.talkMaxDuration = var_77_4

					if var_77_4 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_4 + 0
					end
				end

				arg_74_1.text_.text = var_77_2
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602017", "story_v_out_325602.awb") ~= 0 then
					local var_77_5 = manager.audio:GetVoiceLength("story_v_out_325602", "325602017", "story_v_out_325602.awb") / 1000

					if var_77_5 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + 0
					end

					if var_77_1.prefab_name ~= "" and arg_74_1.actors_[var_77_1.prefab_name] ~= nil then
						local var_77_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_1.prefab_name].transform, "story_v_out_325602", "325602017", "story_v_out_325602.awb")

						arg_74_1:RecordAudio("325602017", var_77_6)
						arg_74_1:RecordAudio("325602017", var_77_6)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_325602", "325602017", "story_v_out_325602.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_325602", "325602017", "story_v_out_325602.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_7 and arg_74_1.time_ < 0 + var_77_7 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play325602018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 325602018
		arg_78_1.duration_ = 3.5

		local var_78_0 = {
			zh = 2.366,
			ja = 3.5
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play325602019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0.2

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10170")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_1 = arg_78_1:GetWordFromCfg(325602018)
				local var_81_2 = arg_78_1:FormatText(var_81_1.content)

				arg_78_1.text_.text = var_81_2

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_4 = 8 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 8)

				if (8 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 8)) > 0 and var_81_0 < var_81_4 then
					arg_78_1.talkMaxDuration = var_81_4

					if var_81_4 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_4 + 0
					end
				end

				arg_78_1.text_.text = var_81_2
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602018", "story_v_out_325602.awb") ~= 0 then
					local var_81_5 = manager.audio:GetVoiceLength("story_v_out_325602", "325602018", "story_v_out_325602.awb") / 1000

					if var_81_5 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + 0
					end

					if var_81_1.prefab_name ~= "" and arg_78_1.actors_[var_81_1.prefab_name] ~= nil then
						local var_81_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_1.prefab_name].transform, "story_v_out_325602", "325602018", "story_v_out_325602.awb")

						arg_78_1:RecordAudio("325602018", var_81_6)
						arg_78_1:RecordAudio("325602018", var_81_6)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_325602", "325602018", "story_v_out_325602.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_325602", "325602018", "story_v_out_325602.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_7 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_7 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_7

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_7 and arg_78_1.time_ < 0 + var_81_7 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play325602019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 325602019
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play325602020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos10170ui_story = arg_82_1.actors_["10170ui_story"].transform.localPosition

				local var_85_0 = GameObjectTools.GetOrAddComponent(arg_82_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_85_0 then
					var_85_0:EnableDynamicBone(false)
				end
			end

			local var_85_1 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_1 then
				arg_82_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_82_1.time_ - 0) / var_85_1)
				arg_82_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["10170ui_story"].transform.position).z)
				arg_82_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["10170ui_story"].transform.localEulerAngles = arg_82_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_1 and arg_82_1.time_ < 0 + var_85_1 + arg_85_0 then
				arg_82_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_82_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["10170ui_story"].transform.position).z)
				arg_82_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["10170ui_story"].transform.localEulerAngles = arg_82_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_85_2 = GameObjectTools.GetOrAddComponent(arg_82_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_85_2 then
					var_85_2:EnableDynamicBone(true)
				end
			end

			local var_85_3 = arg_82_1.actors_["10170ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_3) and arg_82_1.var_.characterEffect10170ui_story == nil then
				arg_82_1.var_.characterEffect10170ui_story = var_85_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_4 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 and not isNil(var_85_3) then
				if arg_82_1.var_.characterEffect10170ui_story and not isNil(var_85_3) then
					arg_82_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_82_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_4)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 and not isNil(var_85_3) and arg_82_1.var_.characterEffect10170ui_story then
				arg_82_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_82_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_85_5 = 0
			local var_85_6 = 1.75

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_5 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_7 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(325602019).content)

				arg_82_1.text_.text = var_85_7

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_9 = 70 <= 0 and var_85_6 or var_85_6 * (utf8.len(var_85_7) / 70)

				if (70 <= 0 and var_85_6 or var_85_6 * (utf8.len(var_85_7) / 70)) > 0 and var_85_6 < var_85_9 then
					arg_82_1.talkMaxDuration = var_85_9

					if var_85_9 + var_85_5 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_9 + var_85_5
					end
				end

				arg_82_1.text_.text = var_85_7
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_10 = math.max(var_85_6, arg_82_1.talkMaxDuration)

			if var_85_5 <= arg_82_1.time_ and arg_82_1.time_ < var_85_5 + var_85_10 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_5) / var_85_10

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_5 + var_85_10 and arg_82_1.time_ < var_85_5 + var_85_10 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play325602020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 325602020
		arg_86_1.duration_ = 6.77

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play325602021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_9001
			local var_89_9000

			if arg_86_1.bgs_.STblack == nil then
				local var_89_0 = Object.Instantiate(arg_86_1.paintGo_)

				var_89_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_89_0.name = "STblack"
				var_89_0.transform.parent = arg_86_1.stage_.transform
				var_89_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.bgs_.STblack = var_89_0
			end

			if 0.6 < arg_86_1.time_ and arg_86_1.time_ <= 0.6 + arg_89_0 then
				local var_89_1 = arg_86_1.bgs_.STblack

				arg_86_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_89_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_89_2 = var_89_1:GetComponent("SpriteRenderer")

				if var_89_2 and var_89_2.sprite then
					local var_89_3 = 2 * (var_89_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_89_1.transform.localScale = Vector3.New(var_89_3 / var_89_2.sprite.bounds.size.y < var_89_3 * manager.ui.mainCameraCom_.aspect / var_89_2.sprite.bounds.size.x and var_89_3 * manager.ui.mainCameraCom_.aspect / var_89_2.sprite.bounds.size.x or var_89_3 / var_89_2.sprite.bounds.size.y, var_89_3 / var_89_2.sprite.bounds.size.y < var_89_3 * manager.ui.mainCameraCom_.aspect / var_89_2.sprite.bounds.size.x and var_89_3 * manager.ui.mainCameraCom_.aspect / var_89_2.sprite.bounds.size.x or var_89_3 / var_89_2.sprite.bounds.size.y, 0)
				end

				for iter_89_0, iter_89_1 in pairs(arg_86_1.bgs_) do
					if iter_89_0 ~= "STblack" then
						iter_89_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				local var_89_4 = arg_86_1.var_.effectpikaihongmeng1

				if not arg_86_1.var_.effectpikaihongmeng1 then
					var_89_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suipian_out"), manager.ui.mainCamera.transform)
					var_89_4.name = "pikaihongmeng1"
					arg_86_1.var_.effectpikaihongmeng1 = var_89_4
				else
					var_89_4.transform:SetParent(var_89_9001)
				end

				var_89_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_89_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.6 < arg_86_1.time_ and arg_86_1.time_ <= 0.6 + arg_89_0 then
				if arg_86_1.var_.effectpikaihongmeng1 then
					Object.Destroy(arg_86_1.var_.effectpikaihongmeng1)

					arg_86_1.var_.effectpikaihongmeng1 = nil
				end
			end

			if 0.6 < arg_86_1.time_ and arg_86_1.time_ <= 0.6 + arg_89_0 then
				local var_89_7 = arg_86_1.var_.effectpikaihongmeng2

				if not arg_86_1.var_.effectpikaihongmeng2 then
					var_89_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), manager.ui.mainCamera.transform)
					var_89_7.name = "pikaihongmeng2"
					arg_86_1.var_.effectpikaihongmeng2 = var_89_7
				else
					var_89_7.transform:SetParent(var_89_9000)
				end

				var_89_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_89_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.5 < arg_86_1.time_ and arg_86_1.time_ <= 2.5 + arg_89_0 then
				if arg_86_1.var_.effectpikaihongmeng2 then
					Object.Destroy(arg_86_1.var_.effectpikaihongmeng2)

					arg_86_1.var_.effectpikaihongmeng2 = nil
				end
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:AudioAction("play", "effect", "se_story_150", "se_story_150_sword10", "")
			end

			if 0.6 < arg_86_1.time_ and arg_86_1.time_ <= 0.6 + arg_89_0 then
				if arg_86_1.var_.effectmantianheiwu2 then
					Object.Destroy(arg_86_1.var_.effectmantianheiwu2)

					arg_86_1.var_.effectmantianheiwu2 = nil
				end
			end

			if arg_86_1.frameCnt_ <= 1 then
				arg_86_1.dialog_:SetActive(false)
			end

			local var_89_12 = 1.76666666666667
			local var_89_13 = 1.725

			if 1.76666666666667 < arg_86_1.time_ and arg_86_1.time_ <= var_89_12 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0

				arg_86_1.dialog_:SetActive(true)

				arg_86_1.dialogCg_.alpha = 0

				local var_89_14 = LeanTween.value(arg_86_1.dialog_, 0, 1, 0.3)

				var_89_14:setOnUpdate(LuaHelper.FloatAction(function(arg_90_0)
					arg_86_1.dialogCg_.alpha = arg_90_0
				end))
				var_89_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_86_1.dialog_)
					var_89_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_86_1.duration_ = arg_86_1.duration_ + 0.3

				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_15 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(325602020).content)

				arg_86_1.text_.text = var_89_15

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_17 = 69 <= 0 and var_89_13 or var_89_13 * (utf8.len(var_89_15) / 69)

				if (69 <= 0 and var_89_13 or var_89_13 * (utf8.len(var_89_15) / 69)) > 0 and var_89_13 < var_89_17 then
					arg_86_1.talkMaxDuration = var_89_17
					var_89_12 = var_89_12 + 0.3

					if var_89_17 + var_89_12 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_17 + var_89_12
					end
				end

				arg_86_1.text_.text = var_89_15
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_18 = var_89_12 + 0.3
			local var_89_19 = math.max(var_89_13, arg_86_1.talkMaxDuration)

			if var_89_12 + 0.3 <= arg_86_1.time_ and arg_86_1.time_ < var_89_18 + var_89_19 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_18) / var_89_19

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_18 + var_89_19 and arg_86_1.time_ < var_89_18 + var_89_19 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play325602021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 325602021
		arg_92_1.duration_ = 3.97

		local var_92_0 = {
			zh = 3.8,
			ja = 3.966
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play325602022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_9000

			if arg_92_1.bgs_.MS2504 == nil then
				local var_95_0 = Object.Instantiate(arg_92_1.paintGo_)

				var_95_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2504")
				var_95_0.name = "MS2504"
				var_95_0.transform.parent = arg_92_1.stage_.transform
				var_95_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_92_1.bgs_.MS2504 = var_95_0
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				local var_95_1 = arg_92_1.bgs_.MS2504

				arg_92_1.bgs_.MS2504.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_95_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_95_2 = var_95_1:GetComponent("SpriteRenderer")

				if var_95_2 and var_95_2.sprite then
					local var_95_3 = 2 * (var_95_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_95_1.transform.localScale = Vector3.New(var_95_3 / var_95_2.sprite.bounds.size.y < var_95_3 * manager.ui.mainCameraCom_.aspect / var_95_2.sprite.bounds.size.x and var_95_3 * manager.ui.mainCameraCom_.aspect / var_95_2.sprite.bounds.size.x or var_95_3 / var_95_2.sprite.bounds.size.y, var_95_3 / var_95_2.sprite.bounds.size.y < var_95_3 * manager.ui.mainCameraCom_.aspect / var_95_2.sprite.bounds.size.x and var_95_3 * manager.ui.mainCameraCom_.aspect / var_95_2.sprite.bounds.size.x or var_95_3 / var_95_2.sprite.bounds.size.y, 0)
				end

				for iter_95_0, iter_95_1 in pairs(arg_92_1.bgs_) do
					if iter_95_0 ~= "MS2504" then
						iter_95_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_95_4 = 1.999999999999

			if 1.999999999999 < arg_92_1.time_ and arg_92_1.time_ <= var_95_4 + arg_95_0 then
				arg_92_1.allBtn_.enabled = false
			end

			if arg_92_1.time_ >= var_95_4 + 0.3 and arg_92_1.time_ < var_95_4 + 0.3 + arg_95_0 then
				arg_92_1.allBtn_.enabled = true
			end

			local var_95_5 = 0

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 then
				arg_92_1.mask_.enabled = true
				arg_92_1.mask_.raycastTarget = true

				arg_92_1:SetGaussion(false)
			end

			local var_95_6 = 0.433333333333333

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_6 then
				local var_95_7 = Color.New(0, 0, 0)

				var_95_7.a = Mathf.Lerp(1, 0, (arg_92_1.time_ - var_95_5) / var_95_6)
				arg_92_1.mask_.color = var_95_7
			end

			if arg_92_1.time_ >= var_95_5 + var_95_6 and arg_92_1.time_ < var_95_5 + var_95_6 + arg_95_0 then
				local var_95_8 = Color.New(0, 0, 0)

				arg_92_1.mask_.enabled = false
				var_95_8.a = 0
				arg_92_1.mask_.color = var_95_8
			end

			local var_95_9 = arg_92_1.actors_["10180ui_story"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos10180ui_story = var_95_9.localPosition

				local var_95_10 = GameObjectTools.GetOrAddComponent(var_95_9.gameObject, typeof(DynamicBoneHelper))

				if var_95_10 then
					var_95_10:EnableDynamicBone(false)
				end
			end

			local var_95_11 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_11 then
				var_95_9.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_92_1.time_ - 0) / var_95_11)
				var_95_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_9.position).x, (manager.ui.mainCamera.transform.position - var_95_9.position).y, (manager.ui.mainCamera.transform.position - var_95_9.position).z)
				var_95_9.localEulerAngles.z = 0
				var_95_9.localEulerAngles.x = 0
				var_95_9.localEulerAngles = var_95_9.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_11 and arg_92_1.time_ < 0 + var_95_11 + arg_95_0 then
				var_95_9.localPosition = Vector3.New(0, 100, 0)
				var_95_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_9.position).x, (manager.ui.mainCamera.transform.position - var_95_9.position).y, (manager.ui.mainCamera.transform.position - var_95_9.position).z)
				var_95_9.localEulerAngles.z = 0
				var_95_9.localEulerAngles.x = 0
				var_95_9.localEulerAngles = var_95_9.localEulerAngles

				local var_95_12 = GameObjectTools.GetOrAddComponent(var_95_9.gameObject, typeof(DynamicBoneHelper))

				if var_95_12 then
					var_95_12:EnableDynamicBone(true)
				end
			end

			local var_95_13 = arg_92_1.actors_["10180ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_13) and arg_92_1.var_.characterEffect10180ui_story == nil then
				arg_92_1.var_.characterEffect10180ui_story = var_95_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_14 = 0.0166666666666667

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_14 and not isNil(var_95_13) then
				if arg_92_1.var_.characterEffect10180ui_story and not isNil(var_95_13) then
					arg_92_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_14 and arg_92_1.time_ < 0 + var_95_14 + arg_95_0 and not isNil(var_95_13) and arg_92_1.var_.characterEffect10180ui_story then
				arg_92_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_95_16 = arg_92_1.bgs_.MS2504.transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPosMS2504 = var_95_16.localPosition
			end

			local var_95_17 = 1

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_17 then
				var_95_16.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPosMS2504, Vector3.New(0, 1, 9.5), (arg_92_1.time_ - 0) / var_95_17)
			end

			if arg_92_1.time_ >= 0 + var_95_17 and arg_92_1.time_ < 0 + var_95_17 + arg_95_0 then
				var_95_16.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_95_18 = arg_92_1.bgs_.MS2504.transform

			if 1 < arg_92_1.time_ and arg_92_1.time_ <= 1 + arg_95_0 then
				arg_92_1.var_.moveOldPosMS2504 = var_95_18.localPosition
			end

			local var_95_19 = 2.500000000001

			if 1 <= arg_92_1.time_ and arg_92_1.time_ < 1 + var_95_19 then
				var_95_18.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPosMS2504, Vector3.New(0, 1, 10), (arg_92_1.time_ - 1) / var_95_19)
			end

			if arg_92_1.time_ >= 1 + var_95_19 and arg_92_1.time_ < 1 + var_95_19 + arg_95_0 then
				var_95_18.localPosition = Vector3.New(0, 1, 10)
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				local var_95_20 = arg_92_1.var_.effectposuitexiao1

				if not arg_92_1.var_.effectposuitexiao1 then
					var_95_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suipian_in"), manager.ui.mainCamera.transform)
					var_95_20.name = "posuitexiao1"
					arg_92_1.var_.effectposuitexiao1 = var_95_20
				else
					var_95_20.transform:SetParent(var_95_9000)
				end

				var_95_20.transform.localPosition = Vector3.New(0, 0, 0)
				var_95_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_95_22 = 0

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_22 + arg_95_0 then
				arg_92_1.allBtn_.enabled = false
			end

			if arg_92_1.time_ >= var_95_22 + 1.999999999999 and arg_92_1.time_ < var_95_22 + 1.999999999999 + arg_95_0 then
				arg_92_1.allBtn_.enabled = true
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				if arg_92_1.var_.effectmantianheiwu1 then
					Object.Destroy(arg_92_1.var_.effectmantianheiwu1)

					arg_92_1.var_.effectmantianheiwu1 = nil
				end
			end

			if 0.1 < arg_92_1.time_ and arg_92_1.time_ <= 0.1 + arg_95_0 then
				arg_92_1:AudioAction("play", "effect", "se_story_148", "se_story_148_bell_temple_china02", "")
			end

			if arg_92_1.frameCnt_ <= 1 then
				arg_92_1.dialog_:SetActive(false)
			end

			local var_95_25 = 2
			local var_95_26 = 0.125

			if 2 < arg_92_1.time_ and arg_92_1.time_ <= var_95_25 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0

				arg_92_1.dialog_:SetActive(true)

				arg_92_1.dialogCg_.alpha = 0

				local var_95_27 = LeanTween.value(arg_92_1.dialog_, 0, 1, 0.3)

				var_95_27:setOnUpdate(LuaHelper.FloatAction(function(arg_96_0)
					arg_92_1.dialogCg_.alpha = arg_96_0
				end))
				var_95_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_92_1.dialog_)
					var_95_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_92_1.duration_ = arg_92_1.duration_ + 0.3

				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_28 = arg_92_1:GetWordFromCfg(325602021)
				local var_95_29 = arg_92_1:FormatText(var_95_28.content)

				arg_92_1.text_.text = var_95_29

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_31 = 5 <= 0 and var_95_26 or var_95_26 * (utf8.len(var_95_29) / 5)

				if (5 <= 0 and var_95_26 or var_95_26 * (utf8.len(var_95_29) / 5)) > 0 and var_95_26 < var_95_31 then
					arg_92_1.talkMaxDuration = var_95_31
					var_95_25 = var_95_25 + 0.3

					if var_95_31 + var_95_25 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_31 + var_95_25
					end
				end

				arg_92_1.text_.text = var_95_29
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602021", "story_v_out_325602.awb") ~= 0 then
					local var_95_32 = manager.audio:GetVoiceLength("story_v_out_325602", "325602021", "story_v_out_325602.awb") / 1000

					if var_95_32 + var_95_25 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_32 + var_95_25
					end

					if var_95_28.prefab_name ~= "" and arg_92_1.actors_[var_95_28.prefab_name] ~= nil then
						local var_95_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_28.prefab_name].transform, "story_v_out_325602", "325602021", "story_v_out_325602.awb")

						arg_92_1:RecordAudio("325602021", var_95_33)
						arg_92_1:RecordAudio("325602021", var_95_33)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_325602", "325602021", "story_v_out_325602.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_325602", "325602021", "story_v_out_325602.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_34 = var_95_25 + 0.3
			local var_95_35 = math.max(var_95_26, arg_92_1.talkMaxDuration)

			if var_95_25 + 0.3 <= arg_92_1.time_ and arg_92_1.time_ < var_95_34 + var_95_35 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_34) / var_95_35

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_34 + var_95_35 and arg_92_1.time_ < var_95_34 + var_95_35 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2504",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 0),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.easeInOutExpo
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2504",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.500000000001,
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play325602022 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 325602022
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play325602023(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos10180ui_story = arg_98_1.actors_["10180ui_story"].transform.localPosition

				local var_101_0 = GameObjectTools.GetOrAddComponent(arg_98_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_101_0 then
					var_101_0:EnableDynamicBone(false)
				end
			end

			local var_101_1 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_1 then
				arg_98_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_98_1.time_ - 0) / var_101_1)
				arg_98_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10180ui_story"].transform.position).z)
				arg_98_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["10180ui_story"].transform.localEulerAngles = arg_98_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_1 and arg_98_1.time_ < 0 + var_101_1 + arg_101_0 then
				arg_98_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_98_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10180ui_story"].transform.position).z)
				arg_98_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["10180ui_story"].transform.localEulerAngles = arg_98_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_101_2 = GameObjectTools.GetOrAddComponent(arg_98_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_101_2 then
					var_101_2:EnableDynamicBone(true)
				end
			end

			local var_101_3 = arg_98_1.actors_["10180ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_3) and arg_98_1.var_.characterEffect10180ui_story == nil then
				arg_98_1.var_.characterEffect10180ui_story = var_101_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_4 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 and not isNil(var_101_3) then
				if arg_98_1.var_.characterEffect10180ui_story and not isNil(var_101_3) then
					arg_98_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_98_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_4)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 and not isNil(var_101_3) and arg_98_1.var_.characterEffect10180ui_story then
				arg_98_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_98_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_101_5 = 0
			local var_101_6 = 1.025

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_7 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(325602022).content)

				arg_98_1.text_.text = var_101_7

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_9 = 41 <= 0 and var_101_6 or var_101_6 * (utf8.len(var_101_7) / 41)

				if (41 <= 0 and var_101_6 or var_101_6 * (utf8.len(var_101_7) / 41)) > 0 and var_101_6 < var_101_9 then
					arg_98_1.talkMaxDuration = var_101_9

					if var_101_9 + var_101_5 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_5
					end
				end

				arg_98_1.text_.text = var_101_7
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_10 = math.max(var_101_6, arg_98_1.talkMaxDuration)

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_10 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_5) / var_101_10

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_5 + var_101_10 and arg_98_1.time_ < var_101_5 + var_101_10 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play325602023 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 325602023
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play325602024(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 1.675

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_1 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(325602023).content)

				arg_102_1.text_.text = var_105_1

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_3 = 67 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_1) / 67)

				if (67 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_1) / 67)) > 0 and var_105_0 < var_105_3 then
					arg_102_1.talkMaxDuration = var_105_3

					if var_105_3 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_3 + 0
					end
				end

				arg_102_1.text_.text = var_105_1
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_4 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_4 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_4

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_4 and arg_102_1.time_ < 0 + var_105_4 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play325602024 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 325602024
		arg_106_1.duration_ = 9.73

		local var_106_0 = {
			zh = 4.1,
			ja = 9.733
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play325602025(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos10180ui_story = arg_106_1.actors_["10180ui_story"].transform.localPosition

				local var_109_0 = GameObjectTools.GetOrAddComponent(arg_106_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_109_0 then
					var_109_0:EnableDynamicBone(false)
				end
			end

			local var_109_1 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_1 then
				arg_106_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_106_1.time_ - 0) / var_109_1)
				arg_106_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["10180ui_story"].transform.position).z)
				arg_106_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["10180ui_story"].transform.localEulerAngles = arg_106_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_1 and arg_106_1.time_ < 0 + var_109_1 + arg_109_0 then
				arg_106_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_106_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_106_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_106_1.actors_["10180ui_story"].transform.position).z)
				arg_106_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_106_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_106_1.actors_["10180ui_story"].transform.localEulerAngles = arg_106_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_109_2 = GameObjectTools.GetOrAddComponent(arg_106_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_109_2 then
					var_109_2:EnableDynamicBone(true)
				end
			end

			local var_109_3 = arg_106_1.actors_["10180ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_3) and arg_106_1.var_.characterEffect10180ui_story == nil then
				arg_106_1.var_.characterEffect10180ui_story = var_109_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_4 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_4 and not isNil(var_109_3) then
				if arg_106_1.var_.characterEffect10180ui_story and not isNil(var_109_3) then
					arg_106_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_4 and arg_106_1.time_ < 0 + var_109_4 + arg_109_0 and not isNil(var_109_3) and arg_106_1.var_.characterEffect10180ui_story then
				arg_106_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_109_6 = 0
			local var_109_7 = 0.35

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_6 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_8 = arg_106_1:GetWordFromCfg(325602024)
				local var_109_9 = arg_106_1:FormatText(var_109_8.content)

				arg_106_1.text_.text = var_109_9

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_11 = 14 <= 0 and var_109_7 or var_109_7 * (utf8.len(var_109_9) / 14)

				if (14 <= 0 and var_109_7 or var_109_7 * (utf8.len(var_109_9) / 14)) > 0 and var_109_7 < var_109_11 then
					arg_106_1.talkMaxDuration = var_109_11

					if var_109_11 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_11 + var_109_6
					end
				end

				arg_106_1.text_.text = var_109_9
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602024", "story_v_out_325602.awb") ~= 0 then
					local var_109_12 = manager.audio:GetVoiceLength("story_v_out_325602", "325602024", "story_v_out_325602.awb") / 1000

					if var_109_12 + var_109_6 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_12 + var_109_6
					end

					if var_109_8.prefab_name ~= "" and arg_106_1.actors_[var_109_8.prefab_name] ~= nil then
						local var_109_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_8.prefab_name].transform, "story_v_out_325602", "325602024", "story_v_out_325602.awb")

						arg_106_1:RecordAudio("325602024", var_109_13)
						arg_106_1:RecordAudio("325602024", var_109_13)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_325602", "325602024", "story_v_out_325602.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_325602", "325602024", "story_v_out_325602.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_14 = math.max(var_109_7, arg_106_1.talkMaxDuration)

			if var_109_6 <= arg_106_1.time_ and arg_106_1.time_ < var_109_6 + var_109_14 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_6) / var_109_14

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_6 + var_109_14 and arg_106_1.time_ < var_109_6 + var_109_14 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play325602025 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 325602025
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play325602026(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos10180ui_story = arg_110_1.actors_["10180ui_story"].transform.localPosition

				local var_113_0 = GameObjectTools.GetOrAddComponent(arg_110_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_113_0 then
					var_113_0:EnableDynamicBone(false)
				end
			end

			local var_113_1 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_1 then
				arg_110_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_110_1.time_ - 0) / var_113_1)
				arg_110_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["10180ui_story"].transform.position).z)
				arg_110_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["10180ui_story"].transform.localEulerAngles = arg_110_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_1 and arg_110_1.time_ < 0 + var_113_1 + arg_113_0 then
				arg_110_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_110_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_110_1.actors_["10180ui_story"].transform.position).z)
				arg_110_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_110_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_110_1.actors_["10180ui_story"].transform.localEulerAngles = arg_110_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_113_2 = GameObjectTools.GetOrAddComponent(arg_110_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_113_2 then
					var_113_2:EnableDynamicBone(true)
				end
			end

			local var_113_3 = arg_110_1.actors_["10180ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_3) and arg_110_1.var_.characterEffect10180ui_story == nil then
				arg_110_1.var_.characterEffect10180ui_story = var_113_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_4 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_4 and not isNil(var_113_3) then
				if arg_110_1.var_.characterEffect10180ui_story and not isNil(var_113_3) then
					arg_110_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_110_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_4)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_4 and arg_110_1.time_ < 0 + var_113_4 + arg_113_0 and not isNil(var_113_3) and arg_110_1.var_.characterEffect10180ui_story then
				arg_110_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_110_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_113_5 = 0
			local var_113_6 = 0.325

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_7 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(325602025).content)

				arg_110_1.text_.text = var_113_7

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_9 = 13 <= 0 and var_113_6 or var_113_6 * (utf8.len(var_113_7) / 13)

				if (13 <= 0 and var_113_6 or var_113_6 * (utf8.len(var_113_7) / 13)) > 0 and var_113_6 < var_113_9 then
					arg_110_1.talkMaxDuration = var_113_9

					if var_113_9 + var_113_5 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_9 + var_113_5
					end
				end

				arg_110_1.text_.text = var_113_7
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_6, arg_110_1.talkMaxDuration)

			if var_113_5 <= arg_110_1.time_ and arg_110_1.time_ < var_113_5 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_5) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_5 + var_113_10 and arg_110_1.time_ < var_113_5 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play325602026 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 325602026
		arg_114_1.duration_ = 10.5

		local var_114_0 = {
			zh = 6.333,
			ja = 10.5
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play325602027(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0.575

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_1 = arg_114_1:GetWordFromCfg(325602026)
				local var_117_2 = arg_114_1:FormatText(var_117_1.content)

				arg_114_1.text_.text = var_117_2

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_4 = 23 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 23)

				if (23 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_2) / 23)) > 0 and var_117_0 < var_117_4 then
					arg_114_1.talkMaxDuration = var_117_4

					if var_117_4 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_4 + 0
					end
				end

				arg_114_1.text_.text = var_117_2
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602026", "story_v_out_325602.awb") ~= 0 then
					local var_117_5 = manager.audio:GetVoiceLength("story_v_out_325602", "325602026", "story_v_out_325602.awb") / 1000

					if var_117_5 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + 0
					end

					if var_117_1.prefab_name ~= "" and arg_114_1.actors_[var_117_1.prefab_name] ~= nil then
						local var_117_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_1.prefab_name].transform, "story_v_out_325602", "325602026", "story_v_out_325602.awb")

						arg_114_1:RecordAudio("325602026", var_117_6)
						arg_114_1:RecordAudio("325602026", var_117_6)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_325602", "325602026", "story_v_out_325602.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_325602", "325602026", "story_v_out_325602.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_7 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_7 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_7

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_7 and arg_114_1.time_ < 0 + var_117_7 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play325602027 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 325602027
		arg_118_1.duration_ = 15.37

		local var_118_0 = {
			zh = 8.5,
			ja = 15.366
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play325602028(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 0.775

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_1 = arg_118_1:GetWordFromCfg(325602027)
				local var_121_2 = arg_118_1:FormatText(var_121_1.content)

				arg_118_1.text_.text = var_121_2

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_4 = 31 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 31)

				if (31 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_2) / 31)) > 0 and var_121_0 < var_121_4 then
					arg_118_1.talkMaxDuration = var_121_4

					if var_121_4 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_4 + 0
					end
				end

				arg_118_1.text_.text = var_121_2
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602027", "story_v_out_325602.awb") ~= 0 then
					local var_121_5 = manager.audio:GetVoiceLength("story_v_out_325602", "325602027", "story_v_out_325602.awb") / 1000

					if var_121_5 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_5 + 0
					end

					if var_121_1.prefab_name ~= "" and arg_118_1.actors_[var_121_1.prefab_name] ~= nil then
						local var_121_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_1.prefab_name].transform, "story_v_out_325602", "325602027", "story_v_out_325602.awb")

						arg_118_1:RecordAudio("325602027", var_121_6)
						arg_118_1:RecordAudio("325602027", var_121_6)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_325602", "325602027", "story_v_out_325602.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_325602", "325602027", "story_v_out_325602.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_7 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_7 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_7

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_7 and arg_118_1.time_ < 0 + var_121_7 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play325602028 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 325602028
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play325602029(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0.2

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, true)
				arg_122_1.iconController_:SetSelectedState("hero")

				arg_122_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_122_1.callingController_:SetSelectedState("normal")

				arg_122_1.keyicon_.color = Color.New(1, 1, 1)
				arg_122_1.icon_.color = Color.New(1, 1, 1)

				local var_125_1 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(325602028).content)

				arg_122_1.text_.text = var_125_1

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_3 = 8 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_1) / 8)

				if (8 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_1) / 8)) > 0 and var_125_0 < var_125_3 then
					arg_122_1.talkMaxDuration = var_125_3

					if var_125_3 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_3 + 0
					end
				end

				arg_122_1.text_.text = var_125_1
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_4 = math.max(var_125_0, arg_122_1.talkMaxDuration)

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_4 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - 0) / var_125_4

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= 0 + var_125_4 and arg_122_1.time_ < 0 + var_125_4 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play325602029 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 325602029
		arg_126_1.duration_ = 12.4

		local var_126_0 = {
			zh = 6.1,
			ja = 12.4
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play325602030(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0.6

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_1 = arg_126_1:GetWordFromCfg(325602029)
				local var_129_2 = arg_126_1:FormatText(var_129_1.content)

				arg_126_1.text_.text = var_129_2

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_4 = 24 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 24)

				if (24 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_2) / 24)) > 0 and var_129_0 < var_129_4 then
					arg_126_1.talkMaxDuration = var_129_4

					if var_129_4 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_4 + 0
					end
				end

				arg_126_1.text_.text = var_129_2
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602029", "story_v_out_325602.awb") ~= 0 then
					local var_129_5 = manager.audio:GetVoiceLength("story_v_out_325602", "325602029", "story_v_out_325602.awb") / 1000

					if var_129_5 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_5 + 0
					end

					if var_129_1.prefab_name ~= "" and arg_126_1.actors_[var_129_1.prefab_name] ~= nil then
						local var_129_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_1.prefab_name].transform, "story_v_out_325602", "325602029", "story_v_out_325602.awb")

						arg_126_1:RecordAudio("325602029", var_129_6)
						arg_126_1:RecordAudio("325602029", var_129_6)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_325602", "325602029", "story_v_out_325602.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_325602", "325602029", "story_v_out_325602.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_7 = math.max(var_129_0, arg_126_1.talkMaxDuration)

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_7 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - 0) / var_129_7

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= 0 + var_129_7 and arg_126_1.time_ < 0 + var_129_7 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play325602030 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 325602030
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play325602031(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos10180ui_story = arg_130_1.actors_["10180ui_story"].transform.localPosition

				local var_133_0 = GameObjectTools.GetOrAddComponent(arg_130_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_133_0 then
					var_133_0:EnableDynamicBone(false)
				end
			end

			local var_133_1 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_1 then
				arg_130_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_130_1.time_ - 0) / var_133_1)
				arg_130_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["10180ui_story"].transform.position).z)
				arg_130_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["10180ui_story"].transform.localEulerAngles = arg_130_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_1 and arg_130_1.time_ < 0 + var_133_1 + arg_133_0 then
				arg_130_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_130_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_130_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_130_1.actors_["10180ui_story"].transform.position).z)
				arg_130_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_130_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_130_1.actors_["10180ui_story"].transform.localEulerAngles = arg_130_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_133_2 = GameObjectTools.GetOrAddComponent(arg_130_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_133_2 then
					var_133_2:EnableDynamicBone(true)
				end
			end

			local var_133_3 = arg_130_1.actors_["10180ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_3) and arg_130_1.var_.characterEffect10180ui_story == nil then
				arg_130_1.var_.characterEffect10180ui_story = var_133_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_4 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 and not isNil(var_133_3) then
				if arg_130_1.var_.characterEffect10180ui_story and not isNil(var_133_3) then
					arg_130_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_130_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_130_1.time_ - 0) / var_133_4)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 and not isNil(var_133_3) and arg_130_1.var_.characterEffect10180ui_story then
				arg_130_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_130_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_133_5 = 0
			local var_133_6 = 0.6

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_7 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(325602030).content)

				arg_130_1.text_.text = var_133_7

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_9 = 24 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_7) / 24)

				if (24 <= 0 and var_133_6 or var_133_6 * (utf8.len(var_133_7) / 24)) > 0 and var_133_6 < var_133_9 then
					arg_130_1.talkMaxDuration = var_133_9

					if var_133_9 + var_133_5 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_9 + var_133_5
					end
				end

				arg_130_1.text_.text = var_133_7
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_10 = math.max(var_133_6, arg_130_1.talkMaxDuration)

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_10 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_5) / var_133_10

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_5 + var_133_10 and arg_130_1.time_ < var_133_5 + var_133_10 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play325602031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 325602031
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play325602032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 1

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_1 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(325602031).content)

				arg_134_1.text_.text = var_137_1

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_3 = 40 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_1) / 40)

				if (40 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_1) / 40)) > 0 and var_137_0 < var_137_3 then
					arg_134_1.talkMaxDuration = var_137_3

					if var_137_3 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_3 + 0
					end
				end

				arg_134_1.text_.text = var_137_1
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_4 = math.max(var_137_0, arg_134_1.talkMaxDuration)

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_4 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - 0) / var_137_4

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= 0 + var_137_4 and arg_134_1.time_ < 0 + var_137_4 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play325602032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 325602032
		arg_138_1.duration_ = 14.33

		local var_138_0 = {
			zh = 12.133,
			ja = 14.333
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play325602033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos10180ui_story = arg_138_1.actors_["10180ui_story"].transform.localPosition

				local var_141_0 = GameObjectTools.GetOrAddComponent(arg_138_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_141_0 then
					var_141_0:EnableDynamicBone(false)
				end
			end

			local var_141_1 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_1 then
				arg_138_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_138_1.time_ - 0) / var_141_1)
				arg_138_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["10180ui_story"].transform.position).z)
				arg_138_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["10180ui_story"].transform.localEulerAngles = arg_138_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_1 and arg_138_1.time_ < 0 + var_141_1 + arg_141_0 then
				arg_138_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_138_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_138_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_138_1.actors_["10180ui_story"].transform.position).z)
				arg_138_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_138_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_138_1.actors_["10180ui_story"].transform.localEulerAngles = arg_138_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_141_2 = GameObjectTools.GetOrAddComponent(arg_138_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_141_2 then
					var_141_2:EnableDynamicBone(true)
				end
			end

			local var_141_3 = arg_138_1.actors_["10180ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_3) and arg_138_1.var_.characterEffect10180ui_story == nil then
				arg_138_1.var_.characterEffect10180ui_story = var_141_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_4 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_4 and not isNil(var_141_3) then
				if arg_138_1.var_.characterEffect10180ui_story and not isNil(var_141_3) then
					arg_138_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_4 and arg_138_1.time_ < 0 + var_141_4 + arg_141_0 and not isNil(var_141_3) and arg_138_1.var_.characterEffect10180ui_story then
				arg_138_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_141_6 = 0
			local var_141_7 = 1.025

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_6 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_8 = arg_138_1:GetWordFromCfg(325602032)
				local var_141_9 = arg_138_1:FormatText(var_141_8.content)

				arg_138_1.text_.text = var_141_9

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_11 = 41 <= 0 and var_141_7 or var_141_7 * (utf8.len(var_141_9) / 41)

				if (41 <= 0 and var_141_7 or var_141_7 * (utf8.len(var_141_9) / 41)) > 0 and var_141_7 < var_141_11 then
					arg_138_1.talkMaxDuration = var_141_11

					if var_141_11 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_11 + var_141_6
					end
				end

				arg_138_1.text_.text = var_141_9
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602032", "story_v_out_325602.awb") ~= 0 then
					local var_141_12 = manager.audio:GetVoiceLength("story_v_out_325602", "325602032", "story_v_out_325602.awb") / 1000

					if var_141_12 + var_141_6 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_12 + var_141_6
					end

					if var_141_8.prefab_name ~= "" and arg_138_1.actors_[var_141_8.prefab_name] ~= nil then
						local var_141_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_8.prefab_name].transform, "story_v_out_325602", "325602032", "story_v_out_325602.awb")

						arg_138_1:RecordAudio("325602032", var_141_13)
						arg_138_1:RecordAudio("325602032", var_141_13)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_325602", "325602032", "story_v_out_325602.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_325602", "325602032", "story_v_out_325602.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_14 = math.max(var_141_7, arg_138_1.talkMaxDuration)

			if var_141_6 <= arg_138_1.time_ and arg_138_1.time_ < var_141_6 + var_141_14 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_6) / var_141_14

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_6 + var_141_14 and arg_138_1.time_ < var_141_6 + var_141_14 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	Play325602033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 325602033
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play325602034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.var_.moveOldPos10180ui_story = arg_142_1.actors_["10180ui_story"].transform.localPosition

				local var_145_0 = GameObjectTools.GetOrAddComponent(arg_142_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_145_0 then
					var_145_0:EnableDynamicBone(false)
				end
			end

			local var_145_1 = 0.001

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_1 then
				arg_142_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_142_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_142_1.time_ - 0) / var_145_1)
				arg_142_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_142_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["10180ui_story"].transform.position).z)
				arg_142_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_142_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_142_1.actors_["10180ui_story"].transform.localEulerAngles = arg_142_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_142_1.time_ >= 0 + var_145_1 and arg_142_1.time_ < 0 + var_145_1 + arg_145_0 then
				arg_142_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_142_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_142_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_142_1.actors_["10180ui_story"].transform.position).z)
				arg_142_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_142_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_142_1.actors_["10180ui_story"].transform.localEulerAngles = arg_142_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_145_2 = GameObjectTools.GetOrAddComponent(arg_142_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_145_2 then
					var_145_2:EnableDynamicBone(true)
				end
			end

			local var_145_3 = arg_142_1.actors_["10180ui_story"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_3) and arg_142_1.var_.characterEffect10180ui_story == nil then
				arg_142_1.var_.characterEffect10180ui_story = var_145_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_4 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_4 and not isNil(var_145_3) then
				if arg_142_1.var_.characterEffect10180ui_story and not isNil(var_145_3) then
					arg_142_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_142_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_142_1.time_ - 0) / var_145_4)
				end
			end

			if arg_142_1.time_ >= 0 + var_145_4 and arg_142_1.time_ < 0 + var_145_4 + arg_145_0 and not isNil(var_145_3) and arg_142_1.var_.characterEffect10180ui_story then
				arg_142_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_142_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_145_5 = 0
			local var_145_6 = 0.975

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_5 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, true)
				arg_142_1.iconController_:SetSelectedState("hero")

				arg_142_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_142_1.callingController_:SetSelectedState("normal")

				arg_142_1.keyicon_.color = Color.New(1, 1, 1)
				arg_142_1.icon_.color = Color.New(1, 1, 1)

				local var_145_7 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(325602033).content)

				arg_142_1.text_.text = var_145_7

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_9 = 39 <= 0 and var_145_6 or var_145_6 * (utf8.len(var_145_7) / 39)

				if (39 <= 0 and var_145_6 or var_145_6 * (utf8.len(var_145_7) / 39)) > 0 and var_145_6 < var_145_9 then
					arg_142_1.talkMaxDuration = var_145_9

					if var_145_9 + var_145_5 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_9 + var_145_5
					end
				end

				arg_142_1.text_.text = var_145_7
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_10 = math.max(var_145_6, arg_142_1.talkMaxDuration)

			if var_145_5 <= arg_142_1.time_ and arg_142_1.time_ < var_145_5 + var_145_10 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_5) / var_145_10

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_5 + var_145_10 and arg_142_1.time_ < var_145_5 + var_145_10 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_142_1:InitPlayNodeList()
	end,
	Play325602034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 325602034
		arg_146_1.duration_ = 20.6

		local var_146_0 = {
			zh = 9.733,
			ja = 20.6
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play325602035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos10180ui_story = arg_146_1.actors_["10180ui_story"].transform.localPosition

				local var_149_0 = GameObjectTools.GetOrAddComponent(arg_146_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_149_0 then
					var_149_0:EnableDynamicBone(false)
				end
			end

			local var_149_1 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_1 then
				arg_146_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_146_1.time_ - 0) / var_149_1)
				arg_146_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["10180ui_story"].transform.position).z)
				arg_146_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["10180ui_story"].transform.localEulerAngles = arg_146_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_1 and arg_146_1.time_ < 0 + var_149_1 + arg_149_0 then
				arg_146_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_146_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_146_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_146_1.actors_["10180ui_story"].transform.position).z)
				arg_146_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_146_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_146_1.actors_["10180ui_story"].transform.localEulerAngles = arg_146_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_149_2 = GameObjectTools.GetOrAddComponent(arg_146_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_149_2 then
					var_149_2:EnableDynamicBone(true)
				end
			end

			local var_149_3 = arg_146_1.actors_["10180ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_3) and arg_146_1.var_.characterEffect10180ui_story == nil then
				arg_146_1.var_.characterEffect10180ui_story = var_149_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_4 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_4 and not isNil(var_149_3) then
				if arg_146_1.var_.characterEffect10180ui_story and not isNil(var_149_3) then
					arg_146_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_4 and arg_146_1.time_ < 0 + var_149_4 + arg_149_0 and not isNil(var_149_3) and arg_146_1.var_.characterEffect10180ui_story then
				arg_146_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_149_6 = 0
			local var_149_7 = 0.925

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_6 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_8 = arg_146_1:GetWordFromCfg(325602034)
				local var_149_9 = arg_146_1:FormatText(var_149_8.content)

				arg_146_1.text_.text = var_149_9

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_11 = 37 <= 0 and var_149_7 or var_149_7 * (utf8.len(var_149_9) / 37)

				if (37 <= 0 and var_149_7 or var_149_7 * (utf8.len(var_149_9) / 37)) > 0 and var_149_7 < var_149_11 then
					arg_146_1.talkMaxDuration = var_149_11

					if var_149_11 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_11 + var_149_6
					end
				end

				arg_146_1.text_.text = var_149_9
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602034", "story_v_out_325602.awb") ~= 0 then
					local var_149_12 = manager.audio:GetVoiceLength("story_v_out_325602", "325602034", "story_v_out_325602.awb") / 1000

					if var_149_12 + var_149_6 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_12 + var_149_6
					end

					if var_149_8.prefab_name ~= "" and arg_146_1.actors_[var_149_8.prefab_name] ~= nil then
						local var_149_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_8.prefab_name].transform, "story_v_out_325602", "325602034", "story_v_out_325602.awb")

						arg_146_1:RecordAudio("325602034", var_149_13)
						arg_146_1:RecordAudio("325602034", var_149_13)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_325602", "325602034", "story_v_out_325602.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_325602", "325602034", "story_v_out_325602.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_14 = math.max(var_149_7, arg_146_1.talkMaxDuration)

			if var_149_6 <= arg_146_1.time_ and arg_146_1.time_ < var_149_6 + var_149_14 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_6) / var_149_14

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_6 + var_149_14 and arg_146_1.time_ < var_149_6 + var_149_14 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play325602035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 325602035
		arg_150_1.duration_ = 5.57

		local var_150_0 = {
			zh = 4.5,
			ja = 5.566
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play325602036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0.325

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_1 = arg_150_1:GetWordFromCfg(325602035)
				local var_153_2 = arg_150_1:FormatText(var_153_1.content)

				arg_150_1.text_.text = var_153_2

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_4 = 13 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 13)

				if (13 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_2) / 13)) > 0 and var_153_0 < var_153_4 then
					arg_150_1.talkMaxDuration = var_153_4

					if var_153_4 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_4 + 0
					end
				end

				arg_150_1.text_.text = var_153_2
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602035", "story_v_out_325602.awb") ~= 0 then
					local var_153_5 = manager.audio:GetVoiceLength("story_v_out_325602", "325602035", "story_v_out_325602.awb") / 1000

					if var_153_5 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_5 + 0
					end

					if var_153_1.prefab_name ~= "" and arg_150_1.actors_[var_153_1.prefab_name] ~= nil then
						local var_153_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_1.prefab_name].transform, "story_v_out_325602", "325602035", "story_v_out_325602.awb")

						arg_150_1:RecordAudio("325602035", var_153_6)
						arg_150_1:RecordAudio("325602035", var_153_6)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_325602", "325602035", "story_v_out_325602.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_325602", "325602035", "story_v_out_325602.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_7 = math.max(var_153_0, arg_150_1.talkMaxDuration)

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_7 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - 0) / var_153_7

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= 0 + var_153_7 and arg_150_1.time_ < 0 + var_153_7 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play325602036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 325602036
		arg_154_1.duration_ = 1.83

		local var_154_0 = {
			zh = 1.766,
			ja = 1.833
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play325602037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos10180ui_story = arg_154_1.actors_["10180ui_story"].transform.localPosition

				local var_157_0 = GameObjectTools.GetOrAddComponent(arg_154_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_157_0 then
					var_157_0:EnableDynamicBone(false)
				end
			end

			local var_157_1 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_1 then
				arg_154_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_154_1.time_ - 0) / var_157_1)
				arg_154_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["10180ui_story"].transform.position).z)
				arg_154_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["10180ui_story"].transform.localEulerAngles = arg_154_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_1 and arg_154_1.time_ < 0 + var_157_1 + arg_157_0 then
				arg_154_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_154_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_154_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_154_1.actors_["10180ui_story"].transform.position).z)
				arg_154_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_154_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_154_1.actors_["10180ui_story"].transform.localEulerAngles = arg_154_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_157_2 = GameObjectTools.GetOrAddComponent(arg_154_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_157_2 then
					var_157_2:EnableDynamicBone(true)
				end
			end

			local var_157_3 = arg_154_1.actors_["10170ui_story"].transform

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.var_.moveOldPos10170ui_story = var_157_3.localPosition

				local var_157_4 = GameObjectTools.GetOrAddComponent(var_157_3.gameObject, typeof(DynamicBoneHelper))

				if var_157_4 then
					var_157_4:EnableDynamicBone(false)
				end
			end

			local var_157_5 = 0.001

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_5 then
				var_157_3.localPosition = Vector3.Lerp(arg_154_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_154_1.time_ - 0) / var_157_5)
				var_157_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_3.position).x, (manager.ui.mainCamera.transform.position - var_157_3.position).y, (manager.ui.mainCamera.transform.position - var_157_3.position).z)
				var_157_3.localEulerAngles.z = 0
				var_157_3.localEulerAngles.x = 0
				var_157_3.localEulerAngles = var_157_3.localEulerAngles
			end

			if arg_154_1.time_ >= 0 + var_157_5 and arg_154_1.time_ < 0 + var_157_5 + arg_157_0 then
				var_157_3.localPosition = Vector3.New(0, 100, 0)
				var_157_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_157_3.position).x, (manager.ui.mainCamera.transform.position - var_157_3.position).y, (manager.ui.mainCamera.transform.position - var_157_3.position).z)
				var_157_3.localEulerAngles.z = 0
				var_157_3.localEulerAngles.x = 0
				var_157_3.localEulerAngles = var_157_3.localEulerAngles

				local var_157_6 = GameObjectTools.GetOrAddComponent(var_157_3.gameObject, typeof(DynamicBoneHelper))

				if var_157_6 then
					var_157_6:EnableDynamicBone(true)
				end
			end

			local var_157_7 = arg_154_1.actors_["10170ui_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_7) and arg_154_1.var_.characterEffect10170ui_story == nil then
				arg_154_1.var_.characterEffect10170ui_story = var_157_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_8 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_8 and not isNil(var_157_7) then
				if arg_154_1.var_.characterEffect10170ui_story and not isNil(var_157_7) then
					arg_154_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= 0 + var_157_8 and arg_154_1.time_ < 0 + var_157_8 + arg_157_0 and not isNil(var_157_7) and arg_154_1.var_.characterEffect10170ui_story then
				arg_154_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_157_10 = arg_154_1.actors_["10180ui_story"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_10) and arg_154_1.var_.characterEffect10180ui_story == nil then
				arg_154_1.var_.characterEffect10180ui_story = var_157_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_11 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_11 and not isNil(var_157_10) then
				if arg_154_1.var_.characterEffect10180ui_story and not isNil(var_157_10) then
					arg_154_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_154_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_154_1.time_ - 0) / var_157_11)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_11 and arg_154_1.time_ < 0 + var_157_11 + arg_157_0 and not isNil(var_157_10) and arg_154_1.var_.characterEffect10180ui_story then
				arg_154_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_154_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_157_12 = 0
			local var_157_13 = 0.225

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_12 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_14 = arg_154_1:GetWordFromCfg(325602036)
				local var_157_15 = arg_154_1:FormatText(var_157_14.content)

				arg_154_1.text_.text = var_157_15

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_17 = 9 <= 0 and var_157_13 or var_157_13 * (utf8.len(var_157_15) / 9)

				if (9 <= 0 and var_157_13 or var_157_13 * (utf8.len(var_157_15) / 9)) > 0 and var_157_13 < var_157_17 then
					arg_154_1.talkMaxDuration = var_157_17

					if var_157_17 + var_157_12 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_17 + var_157_12
					end
				end

				arg_154_1.text_.text = var_157_15
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602036", "story_v_out_325602.awb") ~= 0 then
					local var_157_18 = manager.audio:GetVoiceLength("story_v_out_325602", "325602036", "story_v_out_325602.awb") / 1000

					if var_157_18 + var_157_12 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_18 + var_157_12
					end

					if var_157_14.prefab_name ~= "" and arg_154_1.actors_[var_157_14.prefab_name] ~= nil then
						local var_157_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_14.prefab_name].transform, "story_v_out_325602", "325602036", "story_v_out_325602.awb")

						arg_154_1:RecordAudio("325602036", var_157_19)
						arg_154_1:RecordAudio("325602036", var_157_19)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_325602", "325602036", "story_v_out_325602.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_325602", "325602036", "story_v_out_325602.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_20 = math.max(var_157_13, arg_154_1.talkMaxDuration)

			if var_157_12 <= arg_154_1.time_ and arg_154_1.time_ < var_157_12 + var_157_20 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_12) / var_157_20

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_12 + var_157_20 and arg_154_1.time_ < var_157_12 + var_157_20 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_154_1:InitPlayNodeList()
	end,
	Play325602037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 325602037
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play325602038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos10170ui_story = arg_158_1.actors_["10170ui_story"].transform.localPosition

				local var_161_0 = GameObjectTools.GetOrAddComponent(arg_158_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_161_0 then
					var_161_0:EnableDynamicBone(false)
				end
			end

			local var_161_1 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_1 then
				arg_158_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_158_1.time_ - 0) / var_161_1)
				arg_158_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_158_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["10170ui_story"].transform.position).z)
				arg_158_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_158_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_158_1.actors_["10170ui_story"].transform.localEulerAngles = arg_158_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_158_1.time_ >= 0 + var_161_1 and arg_158_1.time_ < 0 + var_161_1 + arg_161_0 then
				arg_158_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_158_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_158_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_158_1.actors_["10170ui_story"].transform.position).z)
				arg_158_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_158_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_158_1.actors_["10170ui_story"].transform.localEulerAngles = arg_158_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_161_2 = GameObjectTools.GetOrAddComponent(arg_158_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_161_2 then
					var_161_2:EnableDynamicBone(true)
				end
			end

			local var_161_3 = arg_158_1.actors_["10170ui_story"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_3) and arg_158_1.var_.characterEffect10170ui_story == nil then
				arg_158_1.var_.characterEffect10170ui_story = var_161_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_4 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_4 and not isNil(var_161_3) then
				if arg_158_1.var_.characterEffect10170ui_story and not isNil(var_161_3) then
					arg_158_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_158_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_158_1.time_ - 0) / var_161_4)
				end
			end

			if arg_158_1.time_ >= 0 + var_161_4 and arg_158_1.time_ < 0 + var_161_4 + arg_161_0 and not isNil(var_161_3) and arg_158_1.var_.characterEffect10170ui_story then
				arg_158_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_158_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_161_5 = 0
			local var_161_6 = 0.075

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_5 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_7 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(325602037).content)

				arg_158_1.text_.text = var_161_7

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_9 = 3 <= 0 and var_161_6 or var_161_6 * (utf8.len(var_161_7) / 3)

				if (3 <= 0 and var_161_6 or var_161_6 * (utf8.len(var_161_7) / 3)) > 0 and var_161_6 < var_161_9 then
					arg_158_1.talkMaxDuration = var_161_9

					if var_161_9 + var_161_5 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_9 + var_161_5
					end
				end

				arg_158_1.text_.text = var_161_7
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_10 = math.max(var_161_6, arg_158_1.talkMaxDuration)

			if var_161_5 <= arg_158_1.time_ and arg_158_1.time_ < var_161_5 + var_161_10 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_5) / var_161_10

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_5 + var_161_10 and arg_158_1.time_ < var_161_5 + var_161_10 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play325602038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 325602038
		arg_162_1.duration_ = 1.6

		local var_162_0 = {
			zh = 1.533,
			ja = 1.6
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play325602039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 0.175

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_1 = arg_162_1:GetWordFromCfg(325602038)
				local var_165_2 = arg_162_1:FormatText(var_165_1.content)

				arg_162_1.text_.text = var_165_2

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_4 = 7 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_2) / 7)

				if (7 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_2) / 7)) > 0 and var_165_0 < var_165_4 then
					arg_162_1.talkMaxDuration = var_165_4

					if var_165_4 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_4 + 0
					end
				end

				arg_162_1.text_.text = var_165_2
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602038", "story_v_out_325602.awb") ~= 0 then
					local var_165_5 = manager.audio:GetVoiceLength("story_v_out_325602", "325602038", "story_v_out_325602.awb") / 1000

					if var_165_5 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_5 + 0
					end

					if var_165_1.prefab_name ~= "" and arg_162_1.actors_[var_165_1.prefab_name] ~= nil then
						local var_165_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_1.prefab_name].transform, "story_v_out_325602", "325602038", "story_v_out_325602.awb")

						arg_162_1:RecordAudio("325602038", var_165_6)
						arg_162_1:RecordAudio("325602038", var_165_6)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_325602", "325602038", "story_v_out_325602.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_325602", "325602038", "story_v_out_325602.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_7 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_7 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_7

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_7 and arg_162_1.time_ < 0 + var_165_7 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play325602039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 325602039
		arg_166_1.duration_ = 5.2

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play325602040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos10170ui_story = arg_166_1.actors_["10170ui_story"].transform.localPosition

				local var_169_0 = GameObjectTools.GetOrAddComponent(arg_166_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_169_0 then
					var_169_0:EnableDynamicBone(false)
				end
			end

			local var_169_1 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_1 then
				arg_166_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_166_1.time_ - 0) / var_169_1)
				arg_166_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["10170ui_story"].transform.position).z)
				arg_166_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["10170ui_story"].transform.localEulerAngles = arg_166_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_1 and arg_166_1.time_ < 0 + var_169_1 + arg_169_0 then
				arg_166_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_166_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_166_1.actors_["10170ui_story"].transform.position).z)
				arg_166_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_166_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_166_1.actors_["10170ui_story"].transform.localEulerAngles = arg_166_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_169_2 = GameObjectTools.GetOrAddComponent(arg_166_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_169_2 then
					var_169_2:EnableDynamicBone(true)
				end
			end

			local var_169_3 = arg_166_1.actors_["10170ui_story"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_3) and arg_166_1.var_.characterEffect10170ui_story == nil then
				arg_166_1.var_.characterEffect10170ui_story = var_169_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_4 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_4 and not isNil(var_169_3) then
				if arg_166_1.var_.characterEffect10170ui_story and not isNil(var_169_3) then
					arg_166_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_166_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_166_1.time_ - 0) / var_169_4)
				end
			end

			if arg_166_1.time_ >= 0 + var_169_4 and arg_166_1.time_ < 0 + var_169_4 + arg_169_0 and not isNil(var_169_3) and arg_166_1.var_.characterEffect10170ui_story then
				arg_166_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_166_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_169_5 = manager.ui.mainCamera.transform

			if 0.200000002980232 < arg_166_1.time_ and arg_166_1.time_ <= 0.200000002980232 + arg_169_0 then
				arg_166_1.var_.shakeOldPos = var_169_5.localPosition
			end

			local var_169_6 = 0.433333330353101

			if 0.200000002980232 <= arg_166_1.time_ and arg_166_1.time_ < 0.200000002980232 + var_169_6 then
				local var_169_7, var_169_8 = math.modf((arg_166_1.time_ - 0.200000002980232) / 0.066)

				var_169_5.localPosition = Vector3.New(var_169_8 * 0.13, var_169_8 * 0.13, var_169_8 * 0.13) + arg_166_1.var_.shakeOldPos
			end

			if arg_166_1.time_ >= 0.200000002980232 + var_169_6 and arg_166_1.time_ < 0.200000002980232 + var_169_6 + arg_169_0 then
				var_169_5.localPosition = arg_166_1.var_.shakeOldPos
			end

			local var_169_9 = 0

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_9 + arg_169_0 then
				arg_166_1.allBtn_.enabled = false
			end

			if arg_166_1.time_ >= var_169_9 + 1 and arg_166_1.time_ < var_169_9 + 1 + arg_169_0 then
				arg_166_1.allBtn_.enabled = true
			end

			if arg_166_1.frameCnt_ <= 1 then
				arg_166_1.dialog_:SetActive(false)
			end

			local var_169_10 = 0.200000002980232
			local var_169_11 = 1.325

			if 0.200000002980232 < arg_166_1.time_ and arg_166_1.time_ <= var_169_10 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0

				arg_166_1.dialog_:SetActive(true)

				arg_166_1.dialogCg_.alpha = 0

				local var_169_12 = LeanTween.value(arg_166_1.dialog_, 0, 1, 0.3)

				var_169_12:setOnUpdate(LuaHelper.FloatAction(function(arg_170_0)
					arg_166_1.dialogCg_.alpha = arg_170_0
				end))
				var_169_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_166_1.dialog_)
					var_169_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_166_1.duration_ = arg_166_1.duration_ + 0.3

				SetActive(arg_166_1.leftNameGo_, false)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_13 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(325602039).content)

				arg_166_1.text_.text = var_169_13

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_15 = 53 <= 0 and var_169_11 or var_169_11 * (utf8.len(var_169_13) / 53)

				if (53 <= 0 and var_169_11 or var_169_11 * (utf8.len(var_169_13) / 53)) > 0 and var_169_11 < var_169_15 then
					arg_166_1.talkMaxDuration = var_169_15
					var_169_10 = var_169_10 + 0.3

					if var_169_15 + var_169_10 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_15 + var_169_10
					end
				end

				arg_166_1.text_.text = var_169_13
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_16 = var_169_10 + 0.3
			local var_169_17 = math.max(var_169_11, arg_166_1.talkMaxDuration)

			if var_169_10 + 0.3 <= arg_166_1.time_ and arg_166_1.time_ < var_169_16 + var_169_17 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_16) / var_169_17

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_16 + var_169_17 and arg_166_1.time_ < var_169_16 + var_169_17 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play325602040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 325602040
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play325602041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 1.025

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_1 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(325602040).content)

				arg_172_1.text_.text = var_175_1

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_3 = 41 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_1) / 41)

				if (41 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_1) / 41)) > 0 and var_175_0 < var_175_3 then
					arg_172_1.talkMaxDuration = var_175_3

					if var_175_3 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_3 + 0
					end
				end

				arg_172_1.text_.text = var_175_1
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_4 = math.max(var_175_0, arg_172_1.talkMaxDuration)

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_4 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - 0) / var_175_4

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= 0 + var_175_4 and arg_172_1.time_ < 0 + var_175_4 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play325602041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 325602041
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play325602042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				local var_179_0 = arg_176_1.var_.effectwangshucijian1

				if not arg_176_1.var_.effectwangshucijian1 then
					var_179_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang03"), manager.ui.mainCamera.transform)
					var_179_0.name = "wangshucijian1"
					arg_176_1.var_.effectwangshucijian1 = var_179_0
				else
					var_179_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_179_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_179_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_179_2 = 0
			local var_179_3 = 1.425

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_2 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_4 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(325602041).content)

				arg_176_1.text_.text = var_179_4

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_6 = 57 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_4) / 57)

				if (57 <= 0 and var_179_3 or var_179_3 * (utf8.len(var_179_4) / 57)) > 0 and var_179_3 < var_179_6 then
					arg_176_1.talkMaxDuration = var_179_6

					if var_179_6 + var_179_2 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_6 + var_179_2
					end
				end

				arg_176_1.text_.text = var_179_4
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_7 = math.max(var_179_3, arg_176_1.talkMaxDuration)

			if var_179_2 <= arg_176_1.time_ and arg_176_1.time_ < var_179_2 + var_179_7 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_2) / var_179_7

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_2 + var_179_7 and arg_176_1.time_ < var_179_2 + var_179_7 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play325602042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 325602042
		arg_180_1.duration_ = 2.9

		local var_180_0 = {
			zh = 2.133,
			ja = 2.9
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play325602043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = 0.175

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_1 = arg_180_1:GetWordFromCfg(325602042)
				local var_183_2 = arg_180_1:FormatText(var_183_1.content)

				arg_180_1.text_.text = var_183_2

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_4 = 7 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_2) / 7)

				if (7 <= 0 and var_183_0 or var_183_0 * (utf8.len(var_183_2) / 7)) > 0 and var_183_0 < var_183_4 then
					arg_180_1.talkMaxDuration = var_183_4

					if var_183_4 + 0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_4 + 0
					end
				end

				arg_180_1.text_.text = var_183_2
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602042", "story_v_out_325602.awb") ~= 0 then
					local var_183_5 = manager.audio:GetVoiceLength("story_v_out_325602", "325602042", "story_v_out_325602.awb") / 1000

					if var_183_5 + 0 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_5 + 0
					end

					if var_183_1.prefab_name ~= "" and arg_180_1.actors_[var_183_1.prefab_name] ~= nil then
						local var_183_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_1.prefab_name].transform, "story_v_out_325602", "325602042", "story_v_out_325602.awb")

						arg_180_1:RecordAudio("325602042", var_183_6)
						arg_180_1:RecordAudio("325602042", var_183_6)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_325602", "325602042", "story_v_out_325602.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_325602", "325602042", "story_v_out_325602.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_7 = math.max(var_183_0, arg_180_1.talkMaxDuration)

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_7 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - 0) / var_183_7

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= 0 + var_183_7 and arg_180_1.time_ < 0 + var_183_7 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play325602043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 325602043
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play325602044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos10180ui_story = arg_184_1.actors_["10180ui_story"].transform.localPosition

				local var_187_0 = GameObjectTools.GetOrAddComponent(arg_184_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_187_0 then
					var_187_0:EnableDynamicBone(false)
				end
			end

			local var_187_1 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_1 then
				arg_184_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_184_1.time_ - 0) / var_187_1)
				arg_184_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["10180ui_story"].transform.position).z)
				arg_184_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["10180ui_story"].transform.localEulerAngles = arg_184_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_184_1.time_ >= 0 + var_187_1 and arg_184_1.time_ < 0 + var_187_1 + arg_187_0 then
				arg_184_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_184_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_184_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_184_1.actors_["10180ui_story"].transform.position).z)
				arg_184_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_184_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_184_1.actors_["10180ui_story"].transform.localEulerAngles = arg_184_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_187_2 = GameObjectTools.GetOrAddComponent(arg_184_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_187_2 then
					var_187_2:EnableDynamicBone(true)
				end
			end

			local var_187_3 = arg_184_1.actors_["10180ui_story"]

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(var_187_3) and arg_184_1.var_.characterEffect10180ui_story == nil then
				arg_184_1.var_.characterEffect10180ui_story = var_187_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_4 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_4 and not isNil(var_187_3) then
				if arg_184_1.var_.characterEffect10180ui_story and not isNil(var_187_3) then
					arg_184_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_184_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_4)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_4 and arg_184_1.time_ < 0 + var_187_4 + arg_187_0 and not isNil(var_187_3) and arg_184_1.var_.characterEffect10180ui_story then
				arg_184_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_184_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_184_1.time_ and arg_184_1.time_ <= 0.1 + arg_187_0 then
				arg_184_1:AudioAction("play", "effect", "se_story_143", "se_story_143_magic_fire", "")
			end

			local var_187_6 = 0
			local var_187_7 = 0.925

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_6 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_8 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(325602043).content)

				arg_184_1.text_.text = var_187_8

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_10 = 37 <= 0 and var_187_7 or var_187_7 * (utf8.len(var_187_8) / 37)

				if (37 <= 0 and var_187_7 or var_187_7 * (utf8.len(var_187_8) / 37)) > 0 and var_187_7 < var_187_10 then
					arg_184_1.talkMaxDuration = var_187_10

					if var_187_10 + var_187_6 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_10 + var_187_6
					end
				end

				arg_184_1.text_.text = var_187_8
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_11 = math.max(var_187_7, arg_184_1.talkMaxDuration)

			if var_187_6 <= arg_184_1.time_ and arg_184_1.time_ < var_187_6 + var_187_11 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_6) / var_187_11

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_6 + var_187_11 and arg_184_1.time_ < var_187_6 + var_187_11 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play325602044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 325602044
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play325602045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = 1.4

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_1 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(325602044).content)

				arg_188_1.text_.text = var_191_1

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_3 = 56 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_1) / 56)

				if (56 <= 0 and var_191_0 or var_191_0 * (utf8.len(var_191_1) / 56)) > 0 and var_191_0 < var_191_3 then
					arg_188_1.talkMaxDuration = var_191_3

					if var_191_3 + 0 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_3 + 0
					end
				end

				arg_188_1.text_.text = var_191_1
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_4 = math.max(var_191_0, arg_188_1.talkMaxDuration)

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_4 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - 0) / var_191_4

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= 0 + var_191_4 and arg_188_1.time_ < 0 + var_191_4 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play325602045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 325602045
		arg_192_1.duration_ = 9

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play325602046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 2 < arg_192_1.time_ and arg_192_1.time_ <= 2 + arg_195_0 then
				local var_195_0 = arg_192_1.bgs_.J25f

				arg_192_1.bgs_.J25f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_195_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_195_1 = var_195_0:GetComponent("SpriteRenderer")

				if var_195_1 and var_195_1.sprite then
					local var_195_2 = 2 * (var_195_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_195_0.transform.localScale = Vector3.New(var_195_2 / var_195_1.sprite.bounds.size.y < var_195_2 * manager.ui.mainCameraCom_.aspect / var_195_1.sprite.bounds.size.x and var_195_2 * manager.ui.mainCameraCom_.aspect / var_195_1.sprite.bounds.size.x or var_195_2 / var_195_1.sprite.bounds.size.y, var_195_2 / var_195_1.sprite.bounds.size.y < var_195_2 * manager.ui.mainCameraCom_.aspect / var_195_1.sprite.bounds.size.x and var_195_2 * manager.ui.mainCameraCom_.aspect / var_195_1.sprite.bounds.size.x or var_195_2 / var_195_1.sprite.bounds.size.y, 0)
				end

				for iter_195_0, iter_195_1 in pairs(arg_192_1.bgs_) do
					if iter_195_0 ~= "J25f" then
						iter_195_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_195_3 = 3.999999999999

			if 3.999999999999 < arg_192_1.time_ and arg_192_1.time_ <= var_195_3 + arg_195_0 then
				arg_192_1.allBtn_.enabled = false
			end

			if arg_192_1.time_ >= var_195_3 + 0.3 and arg_192_1.time_ < var_195_3 + 0.3 + arg_195_0 then
				arg_192_1.allBtn_.enabled = true
			end

			local var_195_4 = 0

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_4 + arg_195_0 then
				arg_192_1.mask_.enabled = true
				arg_192_1.mask_.raycastTarget = true

				arg_192_1:SetGaussion(false)
			end

			local var_195_5 = 2

			if var_195_4 <= arg_192_1.time_ and arg_192_1.time_ < var_195_4 + var_195_5 then
				local var_195_6 = Color.New(0, 0, 0)

				var_195_6.a = Mathf.Lerp(0, 1, (arg_192_1.time_ - var_195_4) / var_195_5)
				arg_192_1.mask_.color = var_195_6
			end

			if arg_192_1.time_ >= var_195_4 + var_195_5 and arg_192_1.time_ < var_195_4 + var_195_5 + arg_195_0 then
				local var_195_7 = Color.New(0, 0, 0)

				var_195_7.a = 1
				arg_192_1.mask_.color = var_195_7
			end

			local var_195_8 = 2

			if 2 < arg_192_1.time_ and arg_192_1.time_ <= var_195_8 + arg_195_0 then
				arg_192_1.mask_.enabled = true
				arg_192_1.mask_.raycastTarget = true

				arg_192_1:SetGaussion(false)
			end

			local var_195_9 = 2

			if var_195_8 <= arg_192_1.time_ and arg_192_1.time_ < var_195_8 + var_195_9 then
				local var_195_10 = Color.New(0, 0, 0)

				var_195_10.a = Mathf.Lerp(1, 0, (arg_192_1.time_ - var_195_8) / var_195_9)
				arg_192_1.mask_.color = var_195_10
			end

			if arg_192_1.time_ >= var_195_8 + var_195_9 and arg_192_1.time_ < var_195_8 + var_195_9 + arg_195_0 then
				local var_195_11 = Color.New(0, 0, 0)

				arg_192_1.mask_.enabled = false
				var_195_11.a = 0
				arg_192_1.mask_.color = var_195_11
			end

			if 2 < arg_192_1.time_ and arg_192_1.time_ <= 2 + arg_195_0 then
				if arg_192_1.var_.effectposuitexiao1 then
					Object.Destroy(arg_192_1.var_.effectposuitexiao1)

					arg_192_1.var_.effectposuitexiao1 = nil
				end
			end

			if arg_192_1.frameCnt_ <= 1 then
				arg_192_1.dialog_:SetActive(false)
			end

			local var_195_13 = 4
			local var_195_14 = 0.875

			if 4 < arg_192_1.time_ and arg_192_1.time_ <= var_195_13 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0

				arg_192_1.dialog_:SetActive(true)

				arg_192_1.dialogCg_.alpha = 0

				local var_195_15 = LeanTween.value(arg_192_1.dialog_, 0, 1, 0.3)

				var_195_15:setOnUpdate(LuaHelper.FloatAction(function(arg_196_0)
					arg_192_1.dialogCg_.alpha = arg_196_0
				end))
				var_195_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_192_1.dialog_)
					var_195_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_192_1.duration_ = arg_192_1.duration_ + 0.3

				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_16 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(325602045).content)

				arg_192_1.text_.text = var_195_16

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_18 = 35 <= 0 and var_195_14 or var_195_14 * (utf8.len(var_195_16) / 35)

				if (35 <= 0 and var_195_14 or var_195_14 * (utf8.len(var_195_16) / 35)) > 0 and var_195_14 < var_195_18 then
					arg_192_1.talkMaxDuration = var_195_18
					var_195_13 = var_195_13 + 0.3

					if var_195_18 + var_195_13 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_18 + var_195_13
					end
				end

				arg_192_1.text_.text = var_195_16
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_19 = var_195_13 + 0.3
			local var_195_20 = math.max(var_195_14, arg_192_1.talkMaxDuration)

			if var_195_13 + 0.3 <= arg_192_1.time_ and arg_192_1.time_ < var_195_19 + var_195_20 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_19) / var_195_20

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_19 + var_195_20 and arg_192_1.time_ < var_195_19 + var_195_20 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play325602046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 325602046
		arg_198_1.duration_ = 5.9

		local var_198_0 = {
			zh = 3.1,
			ja = 5.9
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play325602047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos10180ui_story = arg_198_1.actors_["10180ui_story"].transform.localPosition

				local var_201_0 = GameObjectTools.GetOrAddComponent(arg_198_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_201_0 then
					var_201_0:EnableDynamicBone(false)
				end
			end

			local var_201_1 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_1 then
				arg_198_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos10180ui_story, Vector3.New(-0.03, -1.09, -6.14), (arg_198_1.time_ - 0) / var_201_1)
				arg_198_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["10180ui_story"].transform.position).z)
				arg_198_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["10180ui_story"].transform.localEulerAngles = arg_198_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_1 and arg_198_1.time_ < 0 + var_201_1 + arg_201_0 then
				arg_198_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(-0.03, -1.09, -6.14)
				arg_198_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["10180ui_story"].transform.position).z)
				arg_198_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["10180ui_story"].transform.localEulerAngles = arg_198_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_201_2 = GameObjectTools.GetOrAddComponent(arg_198_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_201_2 then
					var_201_2:EnableDynamicBone(true)
				end
			end

			local var_201_3 = arg_198_1.actors_["10180ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_3) and arg_198_1.var_.characterEffect10180ui_story == nil then
				arg_198_1.var_.characterEffect10180ui_story = var_201_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_4 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_4 and not isNil(var_201_3) then
				if arg_198_1.var_.characterEffect10180ui_story and not isNil(var_201_3) then
					arg_198_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_4 and arg_198_1.time_ < 0 + var_201_4 + arg_201_0 and not isNil(var_201_3) and arg_198_1.var_.characterEffect10180ui_story then
				arg_198_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action1_1")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_201_6 = 0
			local var_201_7 = 0.35

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_6 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_8 = arg_198_1:GetWordFromCfg(325602046)
				local var_201_9 = arg_198_1:FormatText(var_201_8.content)

				arg_198_1.text_.text = var_201_9

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_11 = 14 <= 0 and var_201_7 or var_201_7 * (utf8.len(var_201_9) / 14)

				if (14 <= 0 and var_201_7 or var_201_7 * (utf8.len(var_201_9) / 14)) > 0 and var_201_7 < var_201_11 then
					arg_198_1.talkMaxDuration = var_201_11

					if var_201_11 + var_201_6 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_11 + var_201_6
					end
				end

				arg_198_1.text_.text = var_201_9
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602046", "story_v_out_325602.awb") ~= 0 then
					local var_201_12 = manager.audio:GetVoiceLength("story_v_out_325602", "325602046", "story_v_out_325602.awb") / 1000

					if var_201_12 + var_201_6 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_12 + var_201_6
					end

					if var_201_8.prefab_name ~= "" and arg_198_1.actors_[var_201_8.prefab_name] ~= nil then
						local var_201_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_8.prefab_name].transform, "story_v_out_325602", "325602046", "story_v_out_325602.awb")

						arg_198_1:RecordAudio("325602046", var_201_13)
						arg_198_1:RecordAudio("325602046", var_201_13)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_325602", "325602046", "story_v_out_325602.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_325602", "325602046", "story_v_out_325602.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_14 = math.max(var_201_7, arg_198_1.talkMaxDuration)

			if var_201_6 <= arg_198_1.time_ and arg_198_1.time_ < var_201_6 + var_201_14 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_6) / var_201_14

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_6 + var_201_14 and arg_198_1.time_ < var_201_6 + var_201_14 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play325602047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 325602047
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play325602048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos10180ui_story = arg_202_1.actors_["10180ui_story"].transform.localPosition

				local var_205_0 = GameObjectTools.GetOrAddComponent(arg_202_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_205_0 then
					var_205_0:EnableDynamicBone(false)
				end
			end

			local var_205_1 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_1 then
				arg_202_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_202_1.time_ - 0) / var_205_1)
				arg_202_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["10180ui_story"].transform.position).z)
				arg_202_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["10180ui_story"].transform.localEulerAngles = arg_202_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_202_1.time_ >= 0 + var_205_1 and arg_202_1.time_ < 0 + var_205_1 + arg_205_0 then
				arg_202_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_202_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["10180ui_story"].transform.position).z)
				arg_202_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["10180ui_story"].transform.localEulerAngles = arg_202_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_205_2 = GameObjectTools.GetOrAddComponent(arg_202_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_205_2 then
					var_205_2:EnableDynamicBone(true)
				end
			end

			local var_205_3 = arg_202_1.actors_["10180ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_3) and arg_202_1.var_.characterEffect10180ui_story == nil then
				arg_202_1.var_.characterEffect10180ui_story = var_205_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_4 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_4 and not isNil(var_205_3) then
				if arg_202_1.var_.characterEffect10180ui_story and not isNil(var_205_3) then
					arg_202_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_202_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_4)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_4 and arg_202_1.time_ < 0 + var_205_4 + arg_205_0 and not isNil(var_205_3) and arg_202_1.var_.characterEffect10180ui_story then
				arg_202_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_202_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_205_5 = 0
			local var_205_6 = 0.15

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_5 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_7 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(325602047).content)

				arg_202_1.text_.text = var_205_7

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_9 = 6 <= 0 and var_205_6 or var_205_6 * (utf8.len(var_205_7) / 6)

				if (6 <= 0 and var_205_6 or var_205_6 * (utf8.len(var_205_7) / 6)) > 0 and var_205_6 < var_205_9 then
					arg_202_1.talkMaxDuration = var_205_9

					if var_205_9 + var_205_5 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_9 + var_205_5
					end
				end

				arg_202_1.text_.text = var_205_7
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_10 = math.max(var_205_6, arg_202_1.talkMaxDuration)

			if var_205_5 <= arg_202_1.time_ and arg_202_1.time_ < var_205_5 + var_205_10 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_5) / var_205_10

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_5 + var_205_10 and arg_202_1.time_ < var_205_5 + var_205_10 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play325602048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 325602048
		arg_206_1.duration_ = 13.7

		local var_206_0 = {
			zh = 5.9,
			ja = 13.7
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play325602049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos10180ui_story = arg_206_1.actors_["10180ui_story"].transform.localPosition

				local var_209_0 = GameObjectTools.GetOrAddComponent(arg_206_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_209_0 then
					var_209_0:EnableDynamicBone(false)
				end
			end

			local var_209_1 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_1 then
				arg_206_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos10180ui_story, Vector3.New(-0.03, -1.09, -6.14), (arg_206_1.time_ - 0) / var_209_1)
				arg_206_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["10180ui_story"].transform.position).z)
				arg_206_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["10180ui_story"].transform.localEulerAngles = arg_206_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_1 and arg_206_1.time_ < 0 + var_209_1 + arg_209_0 then
				arg_206_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(-0.03, -1.09, -6.14)
				arg_206_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["10180ui_story"].transform.position).z)
				arg_206_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["10180ui_story"].transform.localEulerAngles = arg_206_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_209_2 = GameObjectTools.GetOrAddComponent(arg_206_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_209_2 then
					var_209_2:EnableDynamicBone(true)
				end
			end

			local var_209_3 = arg_206_1.actors_["10180ui_story"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_3) and arg_206_1.var_.characterEffect10180ui_story == nil then
				arg_206_1.var_.characterEffect10180ui_story = var_209_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_4 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_4 and not isNil(var_209_3) then
				if arg_206_1.var_.characterEffect10180ui_story and not isNil(var_209_3) then
					arg_206_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_4 and arg_206_1.time_ < 0 + var_209_4 + arg_209_0 and not isNil(var_209_3) and arg_206_1.var_.characterEffect10180ui_story then
				arg_206_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_209_6 = 0
			local var_209_7 = 0.575

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_6 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_8 = arg_206_1:GetWordFromCfg(325602048)
				local var_209_9 = arg_206_1:FormatText(var_209_8.content)

				arg_206_1.text_.text = var_209_9

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_11 = 23 <= 0 and var_209_7 or var_209_7 * (utf8.len(var_209_9) / 23)

				if (23 <= 0 and var_209_7 or var_209_7 * (utf8.len(var_209_9) / 23)) > 0 and var_209_7 < var_209_11 then
					arg_206_1.talkMaxDuration = var_209_11

					if var_209_11 + var_209_6 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_11 + var_209_6
					end
				end

				arg_206_1.text_.text = var_209_9
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602048", "story_v_out_325602.awb") ~= 0 then
					local var_209_12 = manager.audio:GetVoiceLength("story_v_out_325602", "325602048", "story_v_out_325602.awb") / 1000

					if var_209_12 + var_209_6 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_12 + var_209_6
					end

					if var_209_8.prefab_name ~= "" and arg_206_1.actors_[var_209_8.prefab_name] ~= nil then
						local var_209_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_8.prefab_name].transform, "story_v_out_325602", "325602048", "story_v_out_325602.awb")

						arg_206_1:RecordAudio("325602048", var_209_13)
						arg_206_1:RecordAudio("325602048", var_209_13)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_325602", "325602048", "story_v_out_325602.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_325602", "325602048", "story_v_out_325602.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_14 = math.max(var_209_7, arg_206_1.talkMaxDuration)

			if var_209_6 <= arg_206_1.time_ and arg_206_1.time_ < var_209_6 + var_209_14 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_6) / var_209_14

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_6 + var_209_14 and arg_206_1.time_ < var_209_6 + var_209_14 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play325602049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 325602049
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play325602050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos10180ui_story = arg_210_1.actors_["10180ui_story"].transform.localPosition

				local var_213_0 = GameObjectTools.GetOrAddComponent(arg_210_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_213_0 then
					var_213_0:EnableDynamicBone(false)
				end
			end

			local var_213_1 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_1 then
				arg_210_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_210_1.time_ - 0) / var_213_1)
				arg_210_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["10180ui_story"].transform.position).z)
				arg_210_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["10180ui_story"].transform.localEulerAngles = arg_210_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_1 and arg_210_1.time_ < 0 + var_213_1 + arg_213_0 then
				arg_210_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_210_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["10180ui_story"].transform.position).z)
				arg_210_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["10180ui_story"].transform.localEulerAngles = arg_210_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_213_2 = GameObjectTools.GetOrAddComponent(arg_210_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_213_2 then
					var_213_2:EnableDynamicBone(true)
				end
			end

			local var_213_3 = arg_210_1.actors_["10180ui_story"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_3) and arg_210_1.var_.characterEffect10180ui_story == nil then
				arg_210_1.var_.characterEffect10180ui_story = var_213_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_4 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_4 and not isNil(var_213_3) then
				if arg_210_1.var_.characterEffect10180ui_story and not isNil(var_213_3) then
					arg_210_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_210_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_210_1.time_ - 0) / var_213_4)
				end
			end

			if arg_210_1.time_ >= 0 + var_213_4 and arg_210_1.time_ < 0 + var_213_4 + arg_213_0 and not isNil(var_213_3) and arg_210_1.var_.characterEffect10180ui_story then
				arg_210_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_210_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_213_5 = 0
			local var_213_6 = 1.225

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_5 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, false)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_7 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(325602049).content)

				arg_210_1.text_.text = var_213_7

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_9 = 49 <= 0 and var_213_6 or var_213_6 * (utf8.len(var_213_7) / 49)

				if (49 <= 0 and var_213_6 or var_213_6 * (utf8.len(var_213_7) / 49)) > 0 and var_213_6 < var_213_9 then
					arg_210_1.talkMaxDuration = var_213_9

					if var_213_9 + var_213_5 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_9 + var_213_5
					end
				end

				arg_210_1.text_.text = var_213_7
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_10 = math.max(var_213_6, arg_210_1.talkMaxDuration)

			if var_213_5 <= arg_210_1.time_ and arg_210_1.time_ < var_213_5 + var_213_10 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_5) / var_213_10

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_5 + var_213_10 and arg_210_1.time_ < var_213_5 + var_213_10 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_210_1:InitPlayNodeList()
	end,
	Play325602050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 325602050
		arg_214_1.duration_ = 2.6

		local var_214_0 = {
			zh = 2.6,
			ja = 2
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play325602051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos10170ui_story = arg_214_1.actors_["10170ui_story"].transform.localPosition

				local var_217_0 = GameObjectTools.GetOrAddComponent(arg_214_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_217_0 then
					var_217_0:EnableDynamicBone(false)
				end
			end

			local var_217_1 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_1 then
				arg_214_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos10170ui_story, Vector3.New(0, -1.03, -6.05), (arg_214_1.time_ - 0) / var_217_1)
				arg_214_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["10170ui_story"].transform.position).z)
				arg_214_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["10170ui_story"].transform.localEulerAngles = arg_214_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_1 and arg_214_1.time_ < 0 + var_217_1 + arg_217_0 then
				arg_214_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, -1.03, -6.05)
				arg_214_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_214_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_214_1.actors_["10170ui_story"].transform.position).z)
				arg_214_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_214_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_214_1.actors_["10170ui_story"].transform.localEulerAngles = arg_214_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_217_2 = GameObjectTools.GetOrAddComponent(arg_214_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_217_2 then
					var_217_2:EnableDynamicBone(true)
				end
			end

			local var_217_3 = arg_214_1.actors_["10170ui_story"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_3) and arg_214_1.var_.characterEffect10170ui_story == nil then
				arg_214_1.var_.characterEffect10170ui_story = var_217_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_4 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 and not isNil(var_217_3) then
				if arg_214_1.var_.characterEffect10170ui_story and not isNil(var_217_3) then
					arg_214_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 and not isNil(var_217_3) and arg_214_1.var_.characterEffect10170ui_story then
				arg_214_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/story10170/story10170action/10170action1_1")
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("10170ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_217_6 = 0
			local var_217_7 = 0.225

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_6 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_8 = arg_214_1:GetWordFromCfg(325602050)
				local var_217_9 = arg_214_1:FormatText(var_217_8.content)

				arg_214_1.text_.text = var_217_9

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_11 = 9 <= 0 and var_217_7 or var_217_7 * (utf8.len(var_217_9) / 9)

				if (9 <= 0 and var_217_7 or var_217_7 * (utf8.len(var_217_9) / 9)) > 0 and var_217_7 < var_217_11 then
					arg_214_1.talkMaxDuration = var_217_11

					if var_217_11 + var_217_6 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_11 + var_217_6
					end
				end

				arg_214_1.text_.text = var_217_9
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602050", "story_v_out_325602.awb") ~= 0 then
					local var_217_12 = manager.audio:GetVoiceLength("story_v_out_325602", "325602050", "story_v_out_325602.awb") / 1000

					if var_217_12 + var_217_6 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_12 + var_217_6
					end

					if var_217_8.prefab_name ~= "" and arg_214_1.actors_[var_217_8.prefab_name] ~= nil then
						local var_217_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_8.prefab_name].transform, "story_v_out_325602", "325602050", "story_v_out_325602.awb")

						arg_214_1:RecordAudio("325602050", var_217_13)
						arg_214_1:RecordAudio("325602050", var_217_13)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_325602", "325602050", "story_v_out_325602.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_325602", "325602050", "story_v_out_325602.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_14 = math.max(var_217_7, arg_214_1.talkMaxDuration)

			if var_217_6 <= arg_214_1.time_ and arg_214_1.time_ < var_217_6 + var_217_14 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_6) / var_217_14

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_6 + var_217_14 and arg_214_1.time_ < var_217_6 + var_217_14 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play325602051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 325602051
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play325602052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos10170ui_story = arg_218_1.actors_["10170ui_story"].transform.localPosition

				local var_221_0 = GameObjectTools.GetOrAddComponent(arg_218_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_221_0 then
					var_221_0:EnableDynamicBone(false)
				end
			end

			local var_221_1 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_1 then
				arg_218_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_218_1.time_ - 0) / var_221_1)
				arg_218_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["10170ui_story"].transform.position).z)
				arg_218_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["10170ui_story"].transform.localEulerAngles = arg_218_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_1 and arg_218_1.time_ < 0 + var_221_1 + arg_221_0 then
				arg_218_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_218_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["10170ui_story"].transform.position).z)
				arg_218_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["10170ui_story"].transform.localEulerAngles = arg_218_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_221_2 = GameObjectTools.GetOrAddComponent(arg_218_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_221_2 then
					var_221_2:EnableDynamicBone(true)
				end
			end

			local var_221_3 = arg_218_1.actors_["10170ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_3) and arg_218_1.var_.characterEffect10170ui_story == nil then
				arg_218_1.var_.characterEffect10170ui_story = var_221_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_4 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 and not isNil(var_221_3) then
				if arg_218_1.var_.characterEffect10170ui_story and not isNil(var_221_3) then
					arg_218_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_218_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_218_1.time_ - 0) / var_221_4)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 and not isNil(var_221_3) and arg_218_1.var_.characterEffect10170ui_story then
				arg_218_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_218_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_221_5 = 0
			local var_221_6 = 0.725

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_5 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_7 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(325602051).content)

				arg_218_1.text_.text = var_221_7

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_9 = 29 <= 0 and var_221_6 or var_221_6 * (utf8.len(var_221_7) / 29)

				if (29 <= 0 and var_221_6 or var_221_6 * (utf8.len(var_221_7) / 29)) > 0 and var_221_6 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_5 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_5
					end
				end

				arg_218_1.text_.text = var_221_7
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_10 = math.max(var_221_6, arg_218_1.talkMaxDuration)

			if var_221_5 <= arg_218_1.time_ and arg_218_1.time_ < var_221_5 + var_221_10 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_5) / var_221_10

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_5 + var_221_10 and arg_218_1.time_ < var_221_5 + var_221_10 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play325602052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 325602052
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play325602053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 1.45

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_1 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(325602052).content)

				arg_222_1.text_.text = var_225_1

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_3 = 58 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 58)

				if (58 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 58)) > 0 and var_225_0 < var_225_3 then
					arg_222_1.talkMaxDuration = var_225_3

					if var_225_3 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_3 + 0
					end
				end

				arg_222_1.text_.text = var_225_1
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_4 = math.max(var_225_0, arg_222_1.talkMaxDuration)

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_4 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - 0) / var_225_4

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= 0 + var_225_4 and arg_222_1.time_ < 0 + var_225_4 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play325602053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 325602053
		arg_226_1.duration_ = 6.6

		local var_226_0 = {
			zh = 4.633,
			ja = 6.6
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play325602054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos10180ui_story = arg_226_1.actors_["10180ui_story"].transform.localPosition

				local var_229_0 = GameObjectTools.GetOrAddComponent(arg_226_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_229_0 then
					var_229_0:EnableDynamicBone(false)
				end
			end

			local var_229_1 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_1 then
				arg_226_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos10180ui_story, Vector3.New(-0.03, -1.09, -6.14), (arg_226_1.time_ - 0) / var_229_1)
				arg_226_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["10180ui_story"].transform.position).z)
				arg_226_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["10180ui_story"].transform.localEulerAngles = arg_226_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_226_1.time_ >= 0 + var_229_1 and arg_226_1.time_ < 0 + var_229_1 + arg_229_0 then
				arg_226_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(-0.03, -1.09, -6.14)
				arg_226_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["10180ui_story"].transform.position).z)
				arg_226_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["10180ui_story"].transform.localEulerAngles = arg_226_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_229_2 = GameObjectTools.GetOrAddComponent(arg_226_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_229_2 then
					var_229_2:EnableDynamicBone(true)
				end
			end

			local var_229_3 = arg_226_1.actors_["10180ui_story"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_3) and arg_226_1.var_.characterEffect10180ui_story == nil then
				arg_226_1.var_.characterEffect10180ui_story = var_229_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_4 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_4 and not isNil(var_229_3) then
				if arg_226_1.var_.characterEffect10180ui_story and not isNil(var_229_3) then
					arg_226_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= 0 + var_229_4 and arg_226_1.time_ < 0 + var_229_4 + arg_229_0 and not isNil(var_229_3) and arg_226_1.var_.characterEffect10180ui_story then
				arg_226_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/story10180/story10180action/10180action8_1")
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("10180ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_229_6 = 0
			local var_229_7 = 0.45

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_6 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_8 = arg_226_1:GetWordFromCfg(325602053)
				local var_229_9 = arg_226_1:FormatText(var_229_8.content)

				arg_226_1.text_.text = var_229_9

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_11 = 18 <= 0 and var_229_7 or var_229_7 * (utf8.len(var_229_9) / 18)

				if (18 <= 0 and var_229_7 or var_229_7 * (utf8.len(var_229_9) / 18)) > 0 and var_229_7 < var_229_11 then
					arg_226_1.talkMaxDuration = var_229_11

					if var_229_11 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_11 + var_229_6
					end
				end

				arg_226_1.text_.text = var_229_9
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602053", "story_v_out_325602.awb") ~= 0 then
					local var_229_12 = manager.audio:GetVoiceLength("story_v_out_325602", "325602053", "story_v_out_325602.awb") / 1000

					if var_229_12 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_12 + var_229_6
					end

					if var_229_8.prefab_name ~= "" and arg_226_1.actors_[var_229_8.prefab_name] ~= nil then
						local var_229_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_8.prefab_name].transform, "story_v_out_325602", "325602053", "story_v_out_325602.awb")

						arg_226_1:RecordAudio("325602053", var_229_13)
						arg_226_1:RecordAudio("325602053", var_229_13)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_325602", "325602053", "story_v_out_325602.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_325602", "325602053", "story_v_out_325602.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_14 = math.max(var_229_7, arg_226_1.talkMaxDuration)

			if var_229_6 <= arg_226_1.time_ and arg_226_1.time_ < var_229_6 + var_229_14 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_6) / var_229_14

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_6 + var_229_14 and arg_226_1.time_ < var_229_6 + var_229_14 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_226_1:InitPlayNodeList()
	end,
	Play325602054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 325602054
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play325602055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos10180ui_story = arg_230_1.actors_["10180ui_story"].transform.localPosition

				local var_233_0 = GameObjectTools.GetOrAddComponent(arg_230_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_233_0 then
					var_233_0:EnableDynamicBone(false)
				end
			end

			local var_233_1 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_1 then
				arg_230_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_230_1.time_ - 0) / var_233_1)
				arg_230_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["10180ui_story"].transform.position).z)
				arg_230_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["10180ui_story"].transform.localEulerAngles = arg_230_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_1 and arg_230_1.time_ < 0 + var_233_1 + arg_233_0 then
				arg_230_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_230_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["10180ui_story"].transform.position).z)
				arg_230_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["10180ui_story"].transform.localEulerAngles = arg_230_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_233_2 = GameObjectTools.GetOrAddComponent(arg_230_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_233_2 then
					var_233_2:EnableDynamicBone(true)
				end
			end

			local var_233_3 = arg_230_1.actors_["10180ui_story"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_3) and arg_230_1.var_.characterEffect10180ui_story == nil then
				arg_230_1.var_.characterEffect10180ui_story = var_233_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_4 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_4 and not isNil(var_233_3) then
				if arg_230_1.var_.characterEffect10180ui_story and not isNil(var_233_3) then
					arg_230_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_230_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_230_1.time_ - 0) / var_233_4)
				end
			end

			if arg_230_1.time_ >= 0 + var_233_4 and arg_230_1.time_ < 0 + var_233_4 + arg_233_0 and not isNil(var_233_3) and arg_230_1.var_.characterEffect10180ui_story then
				arg_230_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_230_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_233_5 = 0
			local var_233_6 = 0.15

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_5 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_7 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(325602054).content)

				arg_230_1.text_.text = var_233_7

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_9 = 6 <= 0 and var_233_6 or var_233_6 * (utf8.len(var_233_7) / 6)

				if (6 <= 0 and var_233_6 or var_233_6 * (utf8.len(var_233_7) / 6)) > 0 and var_233_6 < var_233_9 then
					arg_230_1.talkMaxDuration = var_233_9

					if var_233_9 + var_233_5 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_9 + var_233_5
					end
				end

				arg_230_1.text_.text = var_233_7
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_10 = math.max(var_233_6, arg_230_1.talkMaxDuration)

			if var_233_5 <= arg_230_1.time_ and arg_230_1.time_ < var_233_5 + var_233_10 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_5) / var_233_10

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_5 + var_233_10 and arg_230_1.time_ < var_233_5 + var_233_10 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play325602055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 325602055
		arg_234_1.duration_ = 6.13

		local var_234_0 = {
			zh = 6.133,
			ja = 5.366
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play325602056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos10180ui_story = arg_234_1.actors_["10180ui_story"].transform.localPosition

				local var_237_0 = GameObjectTools.GetOrAddComponent(arg_234_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_237_0 then
					var_237_0:EnableDynamicBone(false)
				end
			end

			local var_237_1 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_1 then
				arg_234_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10180ui_story, Vector3.New(-0.03, -1.09, -6.14), (arg_234_1.time_ - 0) / var_237_1)
				arg_234_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["10180ui_story"].transform.position).z)
				arg_234_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["10180ui_story"].transform.localEulerAngles = arg_234_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_1 and arg_234_1.time_ < 0 + var_237_1 + arg_237_0 then
				arg_234_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(-0.03, -1.09, -6.14)
				arg_234_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["10180ui_story"].transform.position).z)
				arg_234_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["10180ui_story"].transform.localEulerAngles = arg_234_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_237_2 = GameObjectTools.GetOrAddComponent(arg_234_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_237_2 then
					var_237_2:EnableDynamicBone(true)
				end
			end

			local var_237_3 = arg_234_1.actors_["10180ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_3) and arg_234_1.var_.characterEffect10180ui_story == nil then
				arg_234_1.var_.characterEffect10180ui_story = var_237_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_4 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_4 and not isNil(var_237_3) then
				if arg_234_1.var_.characterEffect10180ui_story and not isNil(var_237_3) then
					arg_234_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_4 and arg_234_1.time_ < 0 + var_237_4 + arg_237_0 and not isNil(var_237_3) and arg_234_1.var_.characterEffect10180ui_story then
				arg_234_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_237_6 = 0
			local var_237_7 = 0.6

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_6 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_8 = arg_234_1:GetWordFromCfg(325602055)
				local var_237_9 = arg_234_1:FormatText(var_237_8.content)

				arg_234_1.text_.text = var_237_9

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_11 = 24 <= 0 and var_237_7 or var_237_7 * (utf8.len(var_237_9) / 24)

				if (24 <= 0 and var_237_7 or var_237_7 * (utf8.len(var_237_9) / 24)) > 0 and var_237_7 < var_237_11 then
					arg_234_1.talkMaxDuration = var_237_11

					if var_237_11 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_11 + var_237_6
					end
				end

				arg_234_1.text_.text = var_237_9
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602055", "story_v_out_325602.awb") ~= 0 then
					local var_237_12 = manager.audio:GetVoiceLength("story_v_out_325602", "325602055", "story_v_out_325602.awb") / 1000

					if var_237_12 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_12 + var_237_6
					end

					if var_237_8.prefab_name ~= "" and arg_234_1.actors_[var_237_8.prefab_name] ~= nil then
						local var_237_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_8.prefab_name].transform, "story_v_out_325602", "325602055", "story_v_out_325602.awb")

						arg_234_1:RecordAudio("325602055", var_237_13)
						arg_234_1:RecordAudio("325602055", var_237_13)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_325602", "325602055", "story_v_out_325602.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_325602", "325602055", "story_v_out_325602.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_14 = math.max(var_237_7, arg_234_1.talkMaxDuration)

			if var_237_6 <= arg_234_1.time_ and arg_234_1.time_ < var_237_6 + var_237_14 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_6) / var_237_14

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_6 + var_237_14 and arg_234_1.time_ < var_237_6 + var_237_14 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play325602056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 325602056
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play325602057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos10180ui_story = arg_238_1.actors_["10180ui_story"].transform.localPosition

				local var_241_0 = GameObjectTools.GetOrAddComponent(arg_238_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_241_0 then
					var_241_0:EnableDynamicBone(false)
				end
			end

			local var_241_1 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_1 then
				arg_238_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_238_1.time_ - 0) / var_241_1)
				arg_238_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["10180ui_story"].transform.position).z)
				arg_238_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["10180ui_story"].transform.localEulerAngles = arg_238_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_1 and arg_238_1.time_ < 0 + var_241_1 + arg_241_0 then
				arg_238_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_238_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["10180ui_story"].transform.position).z)
				arg_238_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["10180ui_story"].transform.localEulerAngles = arg_238_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_241_2 = GameObjectTools.GetOrAddComponent(arg_238_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_241_2 then
					var_241_2:EnableDynamicBone(true)
				end
			end

			local var_241_3 = arg_238_1.actors_["10180ui_story"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_3) and arg_238_1.var_.characterEffect10180ui_story == nil then
				arg_238_1.var_.characterEffect10180ui_story = var_241_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_4 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_4 and not isNil(var_241_3) then
				if arg_238_1.var_.characterEffect10180ui_story and not isNil(var_241_3) then
					arg_238_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_238_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_4)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_4 and arg_238_1.time_ < 0 + var_241_4 + arg_241_0 and not isNil(var_241_3) and arg_238_1.var_.characterEffect10180ui_story then
				arg_238_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_238_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			local var_241_5 = 0
			local var_241_6 = 1.65

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_5 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_7 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(325602056).content)

				arg_238_1.text_.text = var_241_7

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_9 = 66 <= 0 and var_241_6 or var_241_6 * (utf8.len(var_241_7) / 66)

				if (66 <= 0 and var_241_6 or var_241_6 * (utf8.len(var_241_7) / 66)) > 0 and var_241_6 < var_241_9 then
					arg_238_1.talkMaxDuration = var_241_9

					if var_241_9 + var_241_5 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_9 + var_241_5
					end
				end

				arg_238_1.text_.text = var_241_7
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_10 = math.max(var_241_6, arg_238_1.talkMaxDuration)

			if var_241_5 <= arg_238_1.time_ and arg_238_1.time_ < var_241_5 + var_241_10 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_5) / var_241_10

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_5 + var_241_10 and arg_238_1.time_ < var_241_5 + var_241_10 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play325602057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 325602057
		arg_242_1.duration_ = 16.83

		local var_242_0 = {
			zh = 8.333,
			ja = 16.833
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play325602058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos10180ui_story = arg_242_1.actors_["10180ui_story"].transform.localPosition

				local var_245_0 = GameObjectTools.GetOrAddComponent(arg_242_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_245_0 then
					var_245_0:EnableDynamicBone(false)
				end
			end

			local var_245_1 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_1 then
				arg_242_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10180ui_story, Vector3.New(-0.03, -1.09, -6.14), (arg_242_1.time_ - 0) / var_245_1)
				arg_242_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["10180ui_story"].transform.position).z)
				arg_242_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["10180ui_story"].transform.localEulerAngles = arg_242_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_1 and arg_242_1.time_ < 0 + var_245_1 + arg_245_0 then
				arg_242_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(-0.03, -1.09, -6.14)
				arg_242_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["10180ui_story"].transform.position).z)
				arg_242_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["10180ui_story"].transform.localEulerAngles = arg_242_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_245_2 = GameObjectTools.GetOrAddComponent(arg_242_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_245_2 then
					var_245_2:EnableDynamicBone(true)
				end
			end

			local var_245_3 = arg_242_1.actors_["10180ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_3) and arg_242_1.var_.characterEffect10180ui_story == nil then
				arg_242_1.var_.characterEffect10180ui_story = var_245_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_4 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_4 and not isNil(var_245_3) then
				if arg_242_1.var_.characterEffect10180ui_story and not isNil(var_245_3) then
					arg_242_1.var_.characterEffect10180ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_4 and arg_242_1.time_ < 0 + var_245_4 + arg_245_0 and not isNil(var_245_3) and arg_242_1.var_.characterEffect10180ui_story then
				arg_242_1.var_.characterEffect10180ui_story.fillFlat = false
			end

			local var_245_6 = 0
			local var_245_7 = 0.825

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_6 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_8 = arg_242_1:GetWordFromCfg(325602057)
				local var_245_9 = arg_242_1:FormatText(var_245_8.content)

				arg_242_1.text_.text = var_245_9

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_11 = 33 <= 0 and var_245_7 or var_245_7 * (utf8.len(var_245_9) / 33)

				if (33 <= 0 and var_245_7 or var_245_7 * (utf8.len(var_245_9) / 33)) > 0 and var_245_7 < var_245_11 then
					arg_242_1.talkMaxDuration = var_245_11

					if var_245_11 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_11 + var_245_6
					end
				end

				arg_242_1.text_.text = var_245_9
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602057", "story_v_out_325602.awb") ~= 0 then
					local var_245_12 = manager.audio:GetVoiceLength("story_v_out_325602", "325602057", "story_v_out_325602.awb") / 1000

					if var_245_12 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_12 + var_245_6
					end

					if var_245_8.prefab_name ~= "" and arg_242_1.actors_[var_245_8.prefab_name] ~= nil then
						local var_245_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_8.prefab_name].transform, "story_v_out_325602", "325602057", "story_v_out_325602.awb")

						arg_242_1:RecordAudio("325602057", var_245_13)
						arg_242_1:RecordAudio("325602057", var_245_13)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_325602", "325602057", "story_v_out_325602.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_325602", "325602057", "story_v_out_325602.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_14 = math.max(var_245_7, arg_242_1.talkMaxDuration)

			if var_245_6 <= arg_242_1.time_ and arg_242_1.time_ < var_245_6 + var_245_14 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_6) / var_245_14

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_6 + var_245_14 and arg_242_1.time_ < var_245_6 + var_245_14 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play325602058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 325602058
		arg_246_1.duration_ = 11.6

		local var_246_0 = {
			zh = 6.366,
			ja = 11.6
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play325602059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0.425

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[1503].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_1 = arg_246_1:GetWordFromCfg(325602058)
				local var_249_2 = arg_246_1:FormatText(var_249_1.content)

				arg_246_1.text_.text = var_249_2

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_4 = 17 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_2) / 17)

				if (17 <= 0 and var_249_0 or var_249_0 * (utf8.len(var_249_2) / 17)) > 0 and var_249_0 < var_249_4 then
					arg_246_1.talkMaxDuration = var_249_4

					if var_249_4 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_4 + 0
					end
				end

				arg_246_1.text_.text = var_249_2
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602058", "story_v_out_325602.awb") ~= 0 then
					local var_249_5 = manager.audio:GetVoiceLength("story_v_out_325602", "325602058", "story_v_out_325602.awb") / 1000

					if var_249_5 + 0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_5 + 0
					end

					if var_249_1.prefab_name ~= "" and arg_246_1.actors_[var_249_1.prefab_name] ~= nil then
						local var_249_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_1.prefab_name].transform, "story_v_out_325602", "325602058", "story_v_out_325602.awb")

						arg_246_1:RecordAudio("325602058", var_249_6)
						arg_246_1:RecordAudio("325602058", var_249_6)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_325602", "325602058", "story_v_out_325602.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_325602", "325602058", "story_v_out_325602.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_7 = math.max(var_249_0, arg_246_1.talkMaxDuration)

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_7 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - 0) / var_249_7

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= 0 + var_249_7 and arg_246_1.time_ < 0 + var_249_7 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play325602059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 325602059
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play325602060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_9000

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos10180ui_story = arg_250_1.actors_["10180ui_story"].transform.localPosition

				local var_253_0 = GameObjectTools.GetOrAddComponent(arg_250_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_253_0 then
					var_253_0:EnableDynamicBone(false)
				end
			end

			local var_253_1 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_1 then
				arg_250_1.actors_["10180ui_story"].transform.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos10180ui_story, Vector3.New(0, 100, 0), (arg_250_1.time_ - 0) / var_253_1)
				arg_250_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["10180ui_story"].transform.position).z)
				arg_250_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["10180ui_story"].transform.localEulerAngles = arg_250_1.actors_["10180ui_story"].transform.localEulerAngles
			end

			if arg_250_1.time_ >= 0 + var_253_1 and arg_250_1.time_ < 0 + var_253_1 + arg_253_0 then
				arg_250_1.actors_["10180ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_250_1.actors_["10180ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["10180ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["10180ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["10180ui_story"].transform.position).z)
				arg_250_1.actors_["10180ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["10180ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["10180ui_story"].transform.localEulerAngles = arg_250_1.actors_["10180ui_story"].transform.localEulerAngles

				local var_253_2 = GameObjectTools.GetOrAddComponent(arg_250_1.actors_["10180ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_253_2 then
					var_253_2:EnableDynamicBone(true)
				end
			end

			local var_253_3 = arg_250_1.actors_["10180ui_story"]

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(var_253_3) and arg_250_1.var_.characterEffect10180ui_story == nil then
				arg_250_1.var_.characterEffect10180ui_story = var_253_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_4 = 0.200000002980232

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_4 and not isNil(var_253_3) then
				if arg_250_1.var_.characterEffect10180ui_story and not isNil(var_253_3) then
					arg_250_1.var_.characterEffect10180ui_story.fillFlat = true
					arg_250_1.var_.characterEffect10180ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_250_1.time_ - 0) / var_253_4)
				end
			end

			if arg_250_1.time_ >= 0 + var_253_4 and arg_250_1.time_ < 0 + var_253_4 + arg_253_0 and not isNil(var_253_3) and arg_250_1.var_.characterEffect10180ui_story then
				arg_250_1.var_.characterEffect10180ui_story.fillFlat = true
				arg_250_1.var_.characterEffect10180ui_story.fillRatio = 0.5
			end

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				local var_253_5 = arg_250_1.var_.effectgongonglikai

				if not arg_250_1.var_.effectgongonglikai then
					var_253_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heiwu"), manager.ui.mainCamera.transform)
					var_253_5.name = "gongonglikai"
					arg_250_1.var_.effectgongonglikai = var_253_5
				else
					var_253_5.transform:SetParent(var_253_9000)
				end

				var_253_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_253_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 4 < arg_250_1.time_ and arg_250_1.time_ <= 4 + arg_253_0 then
				if arg_250_1.var_.effectgongonglikai then
					Object.Destroy(arg_250_1.var_.effectgongonglikai)

					arg_250_1.var_.effectgongonglikai = nil
				end
			end

			local var_253_8 = 0
			local var_253_9 = 1.7

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_8 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_10 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(325602059).content)

				arg_250_1.text_.text = var_253_10

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_12 = 68 <= 0 and var_253_9 or var_253_9 * (utf8.len(var_253_10) / 68)

				if (68 <= 0 and var_253_9 or var_253_9 * (utf8.len(var_253_10) / 68)) > 0 and var_253_9 < var_253_12 then
					arg_250_1.talkMaxDuration = var_253_12

					if var_253_12 + var_253_8 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_12 + var_253_8
					end
				end

				arg_250_1.text_.text = var_253_10
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_13 = math.max(var_253_9, arg_250_1.talkMaxDuration)

			if var_253_8 <= arg_250_1.time_ and arg_250_1.time_ < var_253_8 + var_253_13 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_8) / var_253_13

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_8 + var_253_13 and arg_250_1.time_ < var_253_8 + var_253_13 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10180ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play325602060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 325602060
		arg_254_1.duration_ = 1.83

		local var_254_0 = {
			zh = 1.466,
			ja = 1.833
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play325602061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos10170ui_story = arg_254_1.actors_["10170ui_story"].transform.localPosition

				local var_257_0 = GameObjectTools.GetOrAddComponent(arg_254_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_257_0 then
					var_257_0:EnableDynamicBone(false)
				end
			end

			local var_257_1 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_1 then
				arg_254_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos10170ui_story, Vector3.New(0, -1.03, -6.05), (arg_254_1.time_ - 0) / var_257_1)
				arg_254_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["10170ui_story"].transform.position).z)
				arg_254_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["10170ui_story"].transform.localEulerAngles = arg_254_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_1 and arg_254_1.time_ < 0 + var_257_1 + arg_257_0 then
				arg_254_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, -1.03, -6.05)
				arg_254_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["10170ui_story"].transform.position).z)
				arg_254_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["10170ui_story"].transform.localEulerAngles = arg_254_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_257_2 = GameObjectTools.GetOrAddComponent(arg_254_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_257_2 then
					var_257_2:EnableDynamicBone(true)
				end
			end

			local var_257_3 = arg_254_1.actors_["10170ui_story"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_3) and arg_254_1.var_.characterEffect10170ui_story == nil then
				arg_254_1.var_.characterEffect10170ui_story = var_257_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_4 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_4 and not isNil(var_257_3) then
				if arg_254_1.var_.characterEffect10170ui_story and not isNil(var_257_3) then
					arg_254_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= 0 + var_257_4 and arg_254_1.time_ < 0 + var_257_4 + arg_257_0 and not isNil(var_257_3) and arg_254_1.var_.characterEffect10170ui_story then
				arg_254_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_257_6 = 0
			local var_257_7 = 0.15

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_6 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_8 = arg_254_1:GetWordFromCfg(325602060)
				local var_257_9 = arg_254_1:FormatText(var_257_8.content)

				arg_254_1.text_.text = var_257_9

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_11 = 6 <= 0 and var_257_7 or var_257_7 * (utf8.len(var_257_9) / 6)

				if (6 <= 0 and var_257_7 or var_257_7 * (utf8.len(var_257_9) / 6)) > 0 and var_257_7 < var_257_11 then
					arg_254_1.talkMaxDuration = var_257_11

					if var_257_11 + var_257_6 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_11 + var_257_6
					end
				end

				arg_254_1.text_.text = var_257_9
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602060", "story_v_out_325602.awb") ~= 0 then
					local var_257_12 = manager.audio:GetVoiceLength("story_v_out_325602", "325602060", "story_v_out_325602.awb") / 1000

					if var_257_12 + var_257_6 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_12 + var_257_6
					end

					if var_257_8.prefab_name ~= "" and arg_254_1.actors_[var_257_8.prefab_name] ~= nil then
						local var_257_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_8.prefab_name].transform, "story_v_out_325602", "325602060", "story_v_out_325602.awb")

						arg_254_1:RecordAudio("325602060", var_257_13)
						arg_254_1:RecordAudio("325602060", var_257_13)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_325602", "325602060", "story_v_out_325602.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_325602", "325602060", "story_v_out_325602.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_14 = math.max(var_257_7, arg_254_1.talkMaxDuration)

			if var_257_6 <= arg_254_1.time_ and arg_254_1.time_ < var_257_6 + var_257_14 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_6) / var_257_14

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_6 + var_257_14 and arg_254_1.time_ < var_257_6 + var_257_14 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play325602061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 325602061
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play325602062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos10170ui_story = arg_258_1.actors_["10170ui_story"].transform.localPosition

				local var_261_0 = GameObjectTools.GetOrAddComponent(arg_258_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_261_0 then
					var_261_0:EnableDynamicBone(false)
				end
			end

			local var_261_1 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_1 then
				arg_258_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_258_1.time_ - 0) / var_261_1)
				arg_258_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["10170ui_story"].transform.position).z)
				arg_258_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["10170ui_story"].transform.localEulerAngles = arg_258_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_1 and arg_258_1.time_ < 0 + var_261_1 + arg_261_0 then
				arg_258_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_258_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["10170ui_story"].transform.position).z)
				arg_258_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["10170ui_story"].transform.localEulerAngles = arg_258_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_261_2 = GameObjectTools.GetOrAddComponent(arg_258_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_261_2 then
					var_261_2:EnableDynamicBone(true)
				end
			end

			local var_261_3 = arg_258_1.actors_["10170ui_story"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_3) and arg_258_1.var_.characterEffect10170ui_story == nil then
				arg_258_1.var_.characterEffect10170ui_story = var_261_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_4 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_4 and not isNil(var_261_3) then
				if arg_258_1.var_.characterEffect10170ui_story and not isNil(var_261_3) then
					arg_258_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_258_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_258_1.time_ - 0) / var_261_4)
				end
			end

			if arg_258_1.time_ >= 0 + var_261_4 and arg_258_1.time_ < 0 + var_261_4 + arg_261_0 and not isNil(var_261_3) and arg_258_1.var_.characterEffect10170ui_story then
				arg_258_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_258_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_261_5 = 0
			local var_261_6 = 0.25

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_5 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_7 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(325602061).content)

				arg_258_1.text_.text = var_261_7

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_9 = 10 <= 0 and var_261_6 or var_261_6 * (utf8.len(var_261_7) / 10)

				if (10 <= 0 and var_261_6 or var_261_6 * (utf8.len(var_261_7) / 10)) > 0 and var_261_6 < var_261_9 then
					arg_258_1.talkMaxDuration = var_261_9

					if var_261_9 + var_261_5 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_9 + var_261_5
					end
				end

				arg_258_1.text_.text = var_261_7
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_10 = math.max(var_261_6, arg_258_1.talkMaxDuration)

			if var_261_5 <= arg_258_1.time_ and arg_258_1.time_ < var_261_5 + var_261_10 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_5) / var_261_10

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_5 + var_261_10 and arg_258_1.time_ < var_261_5 + var_261_10 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play325602062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 325602062
		arg_262_1.duration_ = 4.9

		local var_262_0 = {
			zh = 4.5,
			ja = 4.9
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play325602063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos10170ui_story = arg_262_1.actors_["10170ui_story"].transform.localPosition

				local var_265_0 = GameObjectTools.GetOrAddComponent(arg_262_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_265_0 then
					var_265_0:EnableDynamicBone(false)
				end
			end

			local var_265_1 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_1 then
				arg_262_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos10170ui_story, Vector3.New(0, -1.03, -6.05), (arg_262_1.time_ - 0) / var_265_1)
				arg_262_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["10170ui_story"].transform.position).z)
				arg_262_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["10170ui_story"].transform.localEulerAngles = arg_262_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_262_1.time_ >= 0 + var_265_1 and arg_262_1.time_ < 0 + var_265_1 + arg_265_0 then
				arg_262_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, -1.03, -6.05)
				arg_262_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["10170ui_story"].transform.position).z)
				arg_262_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["10170ui_story"].transform.localEulerAngles = arg_262_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_265_2 = GameObjectTools.GetOrAddComponent(arg_262_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_265_2 then
					var_265_2:EnableDynamicBone(true)
				end
			end

			local var_265_3 = arg_262_1.actors_["10170ui_story"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_3) and arg_262_1.var_.characterEffect10170ui_story == nil then
				arg_262_1.var_.characterEffect10170ui_story = var_265_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_4 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_4 and not isNil(var_265_3) then
				if arg_262_1.var_.characterEffect10170ui_story and not isNil(var_265_3) then
					arg_262_1.var_.characterEffect10170ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= 0 + var_265_4 and arg_262_1.time_ < 0 + var_265_4 + arg_265_0 and not isNil(var_265_3) and arg_262_1.var_.characterEffect10170ui_story then
				arg_262_1.var_.characterEffect10170ui_story.fillFlat = false
			end

			local var_265_6 = 0
			local var_265_7 = 0.4

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_6 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_8 = arg_262_1:GetWordFromCfg(325602062)
				local var_265_9 = arg_262_1:FormatText(var_265_8.content)

				arg_262_1.text_.text = var_265_9

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_11 = 16 <= 0 and var_265_7 or var_265_7 * (utf8.len(var_265_9) / 16)

				if (16 <= 0 and var_265_7 or var_265_7 * (utf8.len(var_265_9) / 16)) > 0 and var_265_7 < var_265_11 then
					arg_262_1.talkMaxDuration = var_265_11

					if var_265_11 + var_265_6 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_11 + var_265_6
					end
				end

				arg_262_1.text_.text = var_265_9
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_325602", "325602062", "story_v_out_325602.awb") ~= 0 then
					local var_265_12 = manager.audio:GetVoiceLength("story_v_out_325602", "325602062", "story_v_out_325602.awb") / 1000

					if var_265_12 + var_265_6 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_12 + var_265_6
					end

					if var_265_8.prefab_name ~= "" and arg_262_1.actors_[var_265_8.prefab_name] ~= nil then
						local var_265_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_8.prefab_name].transform, "story_v_out_325602", "325602062", "story_v_out_325602.awb")

						arg_262_1:RecordAudio("325602062", var_265_13)
						arg_262_1:RecordAudio("325602062", var_265_13)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_325602", "325602062", "story_v_out_325602.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_325602", "325602062", "story_v_out_325602.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_14 = math.max(var_265_7, arg_262_1.talkMaxDuration)

			if var_265_6 <= arg_262_1.time_ and arg_262_1.time_ < var_265_6 + var_265_14 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_6) / var_265_14

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_6 + var_265_14 and arg_262_1.time_ < var_265_6 + var_265_14 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play325602063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 325602063
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play325602064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos10170ui_story = arg_266_1.actors_["10170ui_story"].transform.localPosition

				local var_269_0 = GameObjectTools.GetOrAddComponent(arg_266_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_269_0 then
					var_269_0:EnableDynamicBone(false)
				end
			end

			local var_269_1 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_1 then
				arg_266_1.actors_["10170ui_story"].transform.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos10170ui_story, Vector3.New(0, 100, 0), (arg_266_1.time_ - 0) / var_269_1)
				arg_266_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["10170ui_story"].transform.position).z)
				arg_266_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["10170ui_story"].transform.localEulerAngles = arg_266_1.actors_["10170ui_story"].transform.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_1 and arg_266_1.time_ < 0 + var_269_1 + arg_269_0 then
				arg_266_1.actors_["10170ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_266_1.actors_["10170ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["10170ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["10170ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["10170ui_story"].transform.position).z)
				arg_266_1.actors_["10170ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["10170ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["10170ui_story"].transform.localEulerAngles = arg_266_1.actors_["10170ui_story"].transform.localEulerAngles

				local var_269_2 = GameObjectTools.GetOrAddComponent(arg_266_1.actors_["10170ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_269_2 then
					var_269_2:EnableDynamicBone(true)
				end
			end

			local var_269_3 = arg_266_1.actors_["10170ui_story"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_3) and arg_266_1.var_.characterEffect10170ui_story == nil then
				arg_266_1.var_.characterEffect10170ui_story = var_269_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_4 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_4 and not isNil(var_269_3) then
				if arg_266_1.var_.characterEffect10170ui_story and not isNil(var_269_3) then
					arg_266_1.var_.characterEffect10170ui_story.fillFlat = true
					arg_266_1.var_.characterEffect10170ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_266_1.time_ - 0) / var_269_4)
				end
			end

			if arg_266_1.time_ >= 0 + var_269_4 and arg_266_1.time_ < 0 + var_269_4 + arg_269_0 and not isNil(var_269_3) and arg_266_1.var_.characterEffect10170ui_story then
				arg_266_1.var_.characterEffect10170ui_story.fillFlat = true
				arg_266_1.var_.characterEffect10170ui_story.fillRatio = 0.5
			end

			local var_269_5 = 0
			local var_269_6 = 0.95

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_5 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_7 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(325602063).content)

				arg_266_1.text_.text = var_269_7

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_9 = 38 <= 0 and var_269_6 or var_269_6 * (utf8.len(var_269_7) / 38)

				if (38 <= 0 and var_269_6 or var_269_6 * (utf8.len(var_269_7) / 38)) > 0 and var_269_6 < var_269_9 then
					arg_266_1.talkMaxDuration = var_269_9

					if var_269_9 + var_269_5 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_9 + var_269_5
					end
				end

				arg_266_1.text_.text = var_269_7
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_10 = math.max(var_269_6, arg_266_1.talkMaxDuration)

			if var_269_5 <= arg_266_1.time_ and arg_266_1.time_ < var_269_5 + var_269_10 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_5) / var_269_10

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_5 + var_269_10 and arg_266_1.time_ < var_269_5 + var_269_10 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10170ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play325602064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 325602064
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play325602065(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0.425

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_1 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(325602064).content)

				arg_270_1.text_.text = var_273_1

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_3 = 17 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 17)

				if (17 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_1) / 17)) > 0 and var_273_0 < var_273_3 then
					arg_270_1.talkMaxDuration = var_273_3

					if var_273_3 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_3 + 0
					end
				end

				arg_270_1.text_.text = var_273_1
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_4 = math.max(var_273_0, arg_270_1.talkMaxDuration)

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_4 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - 0) / var_273_4

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= 0 + var_273_4 and arg_270_1.time_ < 0 + var_273_4 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play325602065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 325602065
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play325602066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 1.225

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_1 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(325602065).content)

				arg_274_1.text_.text = var_277_1

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_3 = 49 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 49)

				if (49 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_1) / 49)) > 0 and var_277_0 < var_277_3 then
					arg_274_1.talkMaxDuration = var_277_3

					if var_277_3 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_3 + 0
					end
				end

				arg_274_1.text_.text = var_277_1
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_4 = math.max(var_277_0, arg_274_1.talkMaxDuration)

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_4 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - 0) / var_277_4

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= 0 + var_277_4 and arg_274_1.time_ < 0 + var_277_4 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play325602066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 325602066
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
			arg_278_1.auto_ = false
		end

		function arg_278_1.playNext_(arg_280_0)
			arg_278_1.onStoryFinished_()
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_281_1 = 0
			local var_281_2 = 0.575

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, false)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_3 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(325602066).content)

				arg_278_1.text_.text = var_281_3

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 23 <= 0 and var_281_2 or var_281_2 * (utf8.len(var_281_3) / 23)

				if (23 <= 0 and var_281_2 or var_281_2 * (utf8.len(var_281_3) / 23)) > 0 and var_281_2 < var_281_5 then
					arg_278_1.talkMaxDuration = var_281_5

					if var_281_5 + var_281_1 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_5 + var_281_1
					end
				end

				arg_278_1.text_.text = var_281_3
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_6 = math.max(var_281_2, arg_278_1.talkMaxDuration)

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_6 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_1) / var_281_6

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_1 + var_281_6 and arg_278_1.time_ < var_281_1 + var_281_6 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J25f",
		"TextureConfig/Background/J27f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/MS2504"
	},
	voices = {
		"story_v_out_325602.awb"
	}
}
